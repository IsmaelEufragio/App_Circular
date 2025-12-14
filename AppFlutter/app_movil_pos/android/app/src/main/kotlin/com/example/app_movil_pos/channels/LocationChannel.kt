import android.content.Intent
import android.provider.Settings
import android.content.ActivityNotFoundException
import android.net.Uri
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.BinaryMessenger
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import android.app.Activity
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import android.os.Looper
import android.Manifest
import android.annotation.SuppressLint

class LocationMethodHandler(
    private val messenger: BinaryMessenger,
    channelName: String,
    private val activity: Activity
) {

    private val channel = MethodChannel(messenger, channelName)
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var locationCallback: LocationCallback
    fun setupChannel() {
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(activity)

        channel.setMethodCallHandler { call, result ->
            when (call.method) {
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

    fun onDestroyChannel(){
        if (::locationCallback.isInitialized) {
            fusedLocationClient.removeLocationUpdates(locationCallback)
        }
    }
    @SuppressLint("MissingPermission")
    private fun getCurrentLocation(result: MethodChannel.Result) {
        if (!hasLocationPermission()) {
            val response = mapOf(
                "success" to false,
                "message" to "Se necesitan permisos de ubicación",
                "data" to null
            );
            result.error("PERMISSION_DENIED", "Se necesitan permisos de ubicación", response)
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

                    val response = mapOf(
                        "success" to true,
                        "message" to "Ubicacion Obtenida Correctamente",
                        "data" to locationInfo
                    );
                    result.success(response)
                } ?: run {
                    requestNewLocation(result)
                }
            }
            .addOnFailureListener { exception ->
                val response = mapOf(
                    "success" to false,
                    "message" to "Cuenta con permiso pero se produjo un error en 'addOnFailureListener'. ",
                    "data" to null
                );
                result.error("LOCATION_ERROR", exception.message, response)
            }
    }

    private fun hasLocationPermission(): Boolean {
        return ContextCompat.checkSelfPermission(
            activity, // ¡CORREGIDO!
            Manifest.permission.ACCESS_FINE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED ||
                ContextCompat.checkSelfPermission(
                    activity, // ¡CORREGIDO!
                    Manifest.permission.ACCESS_COARSE_LOCATION
                ) == PackageManager.PERMISSION_GRANTED
    }

    @SuppressLint("MissingPermission")
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
                    val response = mapOf(
                        "success" to true,
                        "message" to "Ubicacion Obtenida Correctamente",
                        "data" to locationInfo
                    );
                    result.success(response)
                } ?: run {
                    val response = mapOf(
                        "success" to false,
                        "message" to "No fue posible obtener la ubicacion en el metodo 'requestNewLocation'. ",
                        "data" to null
                    );
                    result.error("LOCATION_ERROR", "No se pudo obtener ubicación", response)
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

    private fun checkLocationPermissions(result: MethodChannel.Result) {

        val permissionStatus = when {
            ContextCompat.checkSelfPermission(
                activity,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED -> "GRANTED"

            ActivityCompat.shouldShowRequestPermissionRationale(
                activity,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) -> "SHOW_RATIONALE"

            else -> "REQUEST_PERMISSION"
        }

        val response = mapOf(
            "success" to true,
            "message" to "Estado de permisos obtenido",
            "data" to mapOf("status" to permissionStatus)
        )
        result.success(response)
    }
    private fun openAppSettings(result: MethodChannel.Result) {
        try {
            val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)


            val uri = Uri.fromParts("package", activity.packageName, null)
            intent.data = uri

            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_CLEAR_TASK

            activity.startActivity(intent)

            result.success("SETTINGS_OPENED_SPECIFIC")

        } catch (e: ActivityNotFoundException) {
            val fallbackIntent = Intent(Settings.ACTION_SETTINGS)

            activity.startActivity(fallbackIntent)

            result.success("SETTINGS_OPENED_GENERAL")
        } catch (e: Exception) {
            result.error("SETTINGS_ERROR", "No se pudo abrir configuración", e.toString())
        }
    }
}