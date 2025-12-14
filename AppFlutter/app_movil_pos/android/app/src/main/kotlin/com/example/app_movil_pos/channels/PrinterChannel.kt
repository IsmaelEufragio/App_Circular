import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import net.nyx.printerclient.RespuestaServicio
import net.nyx.printerclient.ServicioHelper
import io.flutter.plugin.common.BinaryMessenger

class PrinterMethodHandler(private val messager: BinaryMessenger, channelName : String, private val activity: Activity) {
    private val channel = MethodChannel(messager, channelName)
    private lateinit var servicioHelper: ServicioHelper;
    private val TAG = "PrinterHandler"
    fun setupChannel() {
        servicioHelper = ServicioHelper()
        servicioHelper.conectarServicio(activity)

        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "configLcd" -> {
                    val parametro = call.argument<Int>("parametro")
                    Log.d(TAG, "El parametro que esta llegan: $parametro")
                    if (parametro != null) {
                        configLcd(parametro, result)
                    } else {
                        result.error("INVALID_ARGUMENT", "Falta el parámetro 'parametro'", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    fun onDestroyChannel() {

    }
    private fun print(result: MethodChannel.Result) {
        val response = mapOf(
            "success" to true,
            "message" to "Se llamo correcto al metodo",
            "data" to null
        );
        result.success(response)
    }

    private fun configLcd(parametro: Int, result: MethodChannel.Result) {
        servicioHelper.configLcdAsync(parametro, object : ServicioHelper.RespuestaCallback<String> {
            override fun onSuccess(respuesta: RespuestaServicio<String>) {
                val response = mapOf(
                    "success" to true,
                    "message" to respuesta.message,
                    "data" to respuesta.data
                )
                activity.runOnUiThread { result.success(response) }
            }

            override fun onError(error: RespuestaServicio<String>) {
                activity.runOnUiThread { result.error("CONFIG_LCD_ERROR", error.message, null) }
            }
        })
    }
}