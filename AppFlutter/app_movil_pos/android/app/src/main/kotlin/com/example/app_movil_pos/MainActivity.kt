package com.example.app_movil_pos

import LocationMethodHandler
import PrinterMethodHandler
import ScannerMethodHandler
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
    private val PRINTER_CHANNEL = "com.example.device/printer"
    private val LOCATION_CHANNEL = "com.example.device/location"
    private val SCANNER_CHANNEL = "com.example.device/scanner"

    private lateinit var locationHandler: LocationMethodHandler
    private lateinit var printerMethodHandler: PrinterMethodHandler
    private lateinit var scannerMethodHandler: ScannerMethodHandler
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        printerMethodHandler = PrinterMethodHandler(flutterEngine.dartExecutor.binaryMessenger, PRINTER_CHANNEL, this)
        printerMethodHandler.setupChannel()

        locationHandler = LocationMethodHandler(flutterEngine.dartExecutor.binaryMessenger, LOCATION_CHANNEL,this )
        locationHandler.setupChannel()

        scannerMethodHandler = ScannerMethodHandler(flutterEngine.dartExecutor.binaryMessenger, SCANNER_CHANNEL,this )
        scannerMethodHandler.setupChannel()


    }
    override fun onDestroy() {
        locationHandler.onDestroyChannel()
        printerMethodHandler.onDestroyChannel()
        scannerMethodHandler.onDestroyChannel()
        super.onDestroy()
    }
}
