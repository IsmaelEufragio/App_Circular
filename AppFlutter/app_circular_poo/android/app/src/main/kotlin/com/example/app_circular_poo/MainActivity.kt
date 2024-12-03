package com.example.app_circular_poo
import android.content.BroadcastReceiver

import android.os.Bundle

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Parcelable;

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import net.nyx.printerclient.RespuestaServicio
import net.nyx.printerclient.ServicioHelper


import java.io.FileOutputStream
import java.io.IOException
import java.io.File


class MainActivity: FlutterActivity(){
    private val CHANNEL = "com.example.device/infrared"
    private lateinit var servicioHelper: ServicioHelper;

    private val qscReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            if ("com.android.NYX_QSC_DATA" == intent.action) {
                val qsc = intent.getStringExtra("qsc")
                sendScanResultToFlutter(qsc)
            }
        }
    }

    private fun sendScanResultToFlutter(qsc: String?) {
        // Enviar el resultado del escaneo a Flutter
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, CHANNEL).invokeMethod("onScanResult", qsc)
        }
    }

    private fun registerQscScanReceiver() {
        val filter = IntentFilter()
        filter.addAction("com.android.NYX_QSC_DATA")
        registerReceiver(qscReceiver, filter)
    }

    private fun unregisterQscReceiver() {
        unregisterReceiver(qscReceiver)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        //Registro del receptor cuando la actividad es creada
        registerQscScanReceiver()

        // Inicializa ServicioHelper
        servicioHelper = ServicioHelper()

        // Conectar al servicio al iniciar la actividad
        servicioHelper.conectarServicio(this)

        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
                when (call.method) {
                    "unregisterReceiver" -> {
                        unregisterQscReceiver()
                        result.success(null)
                    }
                    "connectService" -> {
                        connectService(result)
                    }
                    "disconnectService" -> {
                        disconnectService(result)
                    }
                    "configLcd" -> {
                        val parametro = call.argument<Int>("parametro")
                        if (parametro != null) {
                            configLcd(parametro, result)
                        } else {
                            result.error("INVALID_ARGUMENT", "Falta el parámetro 'parametro'", null)
                        }
                    }
                    "triggerScan" -> {
                        try {
                            nyxQscTrigger()
                            result.success("Scan triggered successfully")
                        } catch (e: Exception) {
                            result.error("UNAVAILABLE", "Scan trigger failed", e.message)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    private fun nyxQscTrigger() {
        try {
            FileOutputStream("/sys/devices/platform/printer/scan_trig").use { fos ->
                fos.write("1".toByteArray())
                fos.flush()
                Thread.sleep(3000)
                fos.write("0".toByteArray())
                fos.flush()
            }
        } catch (e: IOException) {
            e.printStackTrace()
        } catch (e: InterruptedException) {
            e.printStackTrace()
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterQscReceiver()
    }

    private fun connectService(result: MethodChannel.Result) {
        servicioHelper.conectarServicio(this)
        result.success("Servicio conectado")
    }

    private fun disconnectService(result: MethodChannel.Result) {
        servicioHelper.desconectarServicio(this)
        result.success("Servicio desconectado")
    }

    private fun configLcd(parametro: Int, result: MethodChannel.Result) {
        servicioHelper.configLcdAsync(parametro, object : ServicioHelper.RespuestaCallback<String> {
            override fun onSuccess(respuesta: RespuestaServicio<String>) {
                val response = mapOf(
                    "success" to true,
                    "message" to respuesta.message,
                    "data" to respuesta.data
                )
                runOnUiThread { result.success(response) }
            }

            override fun onError(error: RespuestaServicio<String>) {
                runOnUiThread { result.error("CONFIG_LCD_ERROR", error.message, null) }
            }
        })
    }
}
