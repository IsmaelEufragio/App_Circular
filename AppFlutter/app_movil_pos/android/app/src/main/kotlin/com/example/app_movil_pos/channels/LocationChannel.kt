// package com.example.app_movil_pos.channel

// import android.content.Context
// import android.location.LocationManager

// import io.flutter.embedding.engine.FlutterEngine
// import android.provider.Settings
// import android.content.ActivityNotFoundException
// import android.net.Uri
// import android.Manifest
// import android.content.pm.PackageManager
// import android.location.Location
// import androidx.core.app.ActivityCompat
// import androidx.core.content.ContextCompat
// import com.google.android.gms.location.FusedLocationProviderClient
// import com.google.android.gms.location.LocationCallback
// import com.google.android.gms.location.LocationRequest
// import com.google.android.gms.location.LocationResult
// import com.google.android.gms.location.LocationServices
// import com.google.android.gms.location.Priority
// import android.os.Looper
// import android.util.Log


// class LocationChannel(private val context: Context) : BaseChannel() {
//     override val channelName: String = "com.example.device/LocationChannel"
//     private lateinit var fusedLocationClient: FusedLocationProviderClient
//     private lateinit var locationCallback: LocationCallback

//     private val locationManager: LocationManager by lazy {
//         context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
//     }

//     override fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
//         when (call.method) {
//             "getCurrentLocation" -> getCurrentLocation(result)
//             "checkLocationPermissions" -> checkLocationPermissions(result)
//             "openAppSettings" -> openAppSettings(call, result)
//             else -> result.notImplemented()
//         }
//     }

//     private fun checkLocationPermissions(result: MethodChannel.Result) {
//         val permissionStatus = when {
//             ContextCompat.checkSelfPermission(this, 
//                 Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED -> "granted"
            
//             ActivityCompat.shouldShowRequestPermissionRationale(
//                 this,
//                 Manifest.permission.ACCESS_FINE_LOCATION
//             ) -> "SHOW_RATIONALE"
//             else -> "REQUEST_PERMISSION"
//         }
        
//         result.success(permissionStatus)
//     }
    
//     private fun hasLocationPermission(): Boolean {
//         return ContextCompat.checkSelfPermission(
//             this,
//             Manifest.permission.ACCESS_FINE_LOCATION
//         ) == PackageManager.PERMISSION_GRANTED ||
//         ContextCompat.checkSelfPermission(
//             this,
//             Manifest.permission.ACCESS_COARSE_LOCATION
//         ) == PackageManager.PERMISSION_GRANTED
//     }
    
//     private fun getCurrentLocation(result: MethodChannel.Result) {
//         if (!hasLocationPermission()) {
//             result.error("PERMISSION_DENIED", "Se necesitan permisos de ubicación", null)
//             return
//         }

//         fusedLocationClient.lastLocation
//             .addOnSuccessListener { location ->
//                 location?.let {
//                     val locationInfo = mapOf(
//                         "latitude" to it.latitude,
//                         "longitude" to it.longitude,
//                         "accuracy" to it.accuracy,
//                         "formatted" to String.format(
//                             "Lat: %.6f, Lon: %.6f\nPrecisión: %.1fm",
//                             it.latitude,
//                             it.longitude,
//                             it.accuracy
//                         )
//                     )
//                     result.success(locationInfo)
//                 } ?: run {
//                     requestNewLocation(result)
//                 }
//             }
//             .addOnFailureListener { exception ->
//                 result.error("LOCATION_ERROR", exception.message, null)
//             }
//     }

//     private fun requestNewLocation(result: MethodChannel.Result) {
//         val locationRequest = LocationRequest.Builder(
//             Priority.PRIORITY_HIGH_ACCURACY,
//             5000L
//         ).apply {
//             setMinUpdateIntervalMillis(5000L)
//             setMaxUpdates(1)
//             setWaitForAccurateLocation(true)
//         }.build()

//         locationCallback = object : LocationCallback() {
//             override fun onLocationResult(locationResult: LocationResult) {
//                 locationResult.lastLocation?.let { location ->
//                     val locationInfo = mapOf(
//                         "latitude" to location.latitude,
//                         "longitude" to location.longitude,
//                         "accuracy" to location.accuracy,
//                         "formatted" to String.format(
//                             "Lat: %.6f, Lon: %.6f\nPrecisión: %.1fm",
//                             location.latitude,
//                             location.longitude,
//                             location.accuracy
//                         )
//                     )
//                     result.success(locationInfo)
//                 } ?: run {
//                     result.error("LOCATION_ERROR", "No se pudo obtener ubicación", null)
//                 }
//                 fusedLocationClient.removeLocationUpdates(this)
//             }
//         }

//         fusedLocationClient.requestLocationUpdates(
//             locationRequest,
//             locationCallback,
//             Looper.getMainLooper()
//         )
//     }

//     private fun openAppSettings(result: MethodChannel.Result) {
//         try {
//             val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
//             val uri = Uri.fromParts("package", packageName, null)
//             intent.data = uri
            
//             // Agregar flags para limpiar el stack
//             intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or 
//                         Intent.FLAG_ACTIVITY_CLEAR_TASK
            
//             startActivity(intent)
//             result.success("SETTINGS_OPENED")
//         } catch (e: ActivityNotFoundException) {
//             // Fallback a configuración general
//             val fallbackIntent = Intent(Settings.ACTION_SETTINGS)
//             startActivity(fallbackIntent)
//             result.success("SETTINGS_OPENED_GENERAL")
//         } catch (e: Exception) {
//             result.error("SETTINGS_ERROR", "No se pudo abrir configuración", e.toString())
//         }
//     }
// }