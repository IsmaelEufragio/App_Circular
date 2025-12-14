import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

import java.io.FileOutputStream
import java.io.IOException

import android.util.Log

class ScannerMethodHandler(private val messager: BinaryMessenger, channelName : String, private val activity: Activity){
    private val channel = MethodChannel(messager, channelName)
    private val QSC_ACTION = "com.android.NYX_QSC_DATA"
    private val TAG = "ScannerHandler"

    fun setupChannel() {
        registerQscScanReceiver()
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "triggerScan" -> {
                    try {
                        nyxQscTrigger()
                        val response = mapOf(
                            "success" to true,
                            "message" to "Escaneo activado con éxito",
                            "data" to null
                        );

                        result.success(response)
                    } catch (e: Exception) {
                        result.error("UNAVAILABLE", "Scan trigger failed", e.message)
                    }//print(result)
                }
                else -> result.notImplemented()
            }
        }
    }

    fun onDestroyChannel() {
        unregisterQscReceiver()
    }

    private val qscReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            Log.d(TAG, "Función qscReceiver Kotlin")
            if (QSC_ACTION == intent.action) {
                val qsc = intent.getStringExtra("qsc")
                sendScanResultToFlutter(qsc)
            }
        }
    }

    private fun sendScanResultToFlutter(qsc: String?) {
        Log.d(TAG, "Función sendScanResultToFlutter llamada. QSC recibido Kotlin: $qsc")
        val response = if (qsc.isNullOrEmpty()) {
            mapOf(
                "success" to false,
                "message" to "El escaneo no devolvió datos (QSC nulo o vacío)",
                "data" to null
            )
        } else {
            mapOf(
                "success" to true,
                "message" to "Escaneo de QSC recibido",
                "data" to mapOf("qscCode" to qsc)
            )
        }

        channel.invokeMethod("onScanDataReceived", response)
    }

    private fun registerQscScanReceiver() {
        val filter = IntentFilter()
        filter.addAction(QSC_ACTION)
        activity.registerReceiver(qscReceiver, filter)
    }

    private fun unregisterQscReceiver() {
        activity.unregisterReceiver(qscReceiver)
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
}