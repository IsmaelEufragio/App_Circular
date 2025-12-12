package com.example.app_movil_pos

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

// ========== NUEVAS IMPORTACIONES PARA UBICACIÓN ==========
import io.flutter.embedding.engine.FlutterEngine
import android.provider.Settings
import android.content.ActivityNotFoundException
import android.net.Uri
import android.Manifest
import android.content.pm.PackageManager
import android.location.Location
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import android.os.Looper
import android.util.Log


class MainActivity: FlutterActivity(){
    private val CHANNEL = "com.example.device/infrared"
    private lateinit var servicioHelper: ServicioHelper;
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var locationCallback: LocationCallback

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
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)

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
                    "getCurrentLocation" -> {
                        getCurrentLocation(result)
                    }
                    "checkLocationPermissions" -> {
                        checkLocationPermissions(result)
                    }
                    "openAppSettings" -> {
                        openAppSettings(result)
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
        if (::locationCallback.isInitialized) {
            fusedLocationClient.removeLocationUpdates(locationCallback)
        }
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
    
    /*  Ubicacion Chanel */
    private fun checkLocationPermissions(result: MethodChannel.Result) {
        val permissionStatus = when {
            ContextCompat.checkSelfPermission(this, 
                Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED -> "granted"
            
            ActivityCompat.shouldShowRequestPermissionRationale(
                this,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) -> "SHOW_RATIONALE"
            else -> "REQUEST_PERMISSION"
        }
        
        result.success(permissionStatus)
    }

    private fun hasLocationPermission(): Boolean {
        return ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.ACCESS_FINE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED ||
        ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.ACCESS_COARSE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED
    }
    
    private fun getCurrentLocation(result: MethodChannel.Result) {
        if (!hasLocationPermission()) {
            result.error("PERMISSION_DENIED", "Se necesitan permisos de ubicación", null)
            return
        }

        fusedLocationClient.lastLocation
            .addOnSuccessListener { location ->
                location?.let {
                    val locationInfo = mapOf(
                        "latitude" to it.latitude,
                        "longitude" to it.longitude,
                        "accuracy" to it.accuracy,
                        "formatted" to String.format(
                            "Lat: %.6f, Lon: %.6f\nPrecisión: %.1fm",
                            it.latitude,
                            it.longitude,
                            it.accuracy
                        )
                    )
                    result.success(locationInfo)
                } ?: run {
                    requestNewLocation(result)
                }
            }
            .addOnFailureListener { exception ->
                result.error("LOCATION_ERROR", exception.message, null)
            }
    }

    private fun requestNewLocation(result: MethodChannel.Result) {
        val locationRequest = LocationRequest.Builder(
            Priority.PRIORITY_HIGH_ACCURACY,
            5000L
        ).apply {
            setMinUpdateIntervalMillis(5000L)
            setMaxUpdates(1)
            setWaitForAccurateLocation(true)
        }.build()

        locationCallback = object : LocationCallback() {
            override fun onLocationResult(locationResult: LocationResult) {
                locationResult.lastLocation?.let { location ->
                    val locationInfo = mapOf(
                        "latitude" to location.latitude,
                        "longitude" to location.longitude,
                        "accuracy" to location.accuracy,
                        "formatted" to String.format(
                            "Lat: %.6f, Lon: %.6f\nPrecisión: %.1fm",
                            location.latitude,
                            location.longitude,
                            location.accuracy
                        )
                    )
                    result.success(locationInfo)
                } ?: run {
                    result.error("LOCATION_ERROR", "No se pudo obtener ubicación", null)
                }
                fusedLocationClient.removeLocationUpdates(this)
            }
        }

        fusedLocationClient.requestLocationUpdates(
            locationRequest,
            locationCallback,
            Looper.getMainLooper()
        )
    }

    private fun openAppSettings(result: MethodChannel.Result) {
        try {
            val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
            val uri = Uri.fromParts("package", packageName, null)
            intent.data = uri
            
            // Agregar flags para limpiar el stack
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or 
                        Intent.FLAG_ACTIVITY_CLEAR_TASK
            
            startActivity(intent)
            result.success("SETTINGS_OPENED")
        } catch (e: ActivityNotFoundException) {
            // Fallback a configuración general
            val fallbackIntent = Intent(Settings.ACTION_SETTINGS)
            startActivity(fallbackIntent)
            result.success("SETTINGS_OPENED_GENERAL")
        } catch (e: Exception) {
            result.error("SETTINGS_ERROR", "No se pudo abrir configuración", e.toString())
        }
    }
}
