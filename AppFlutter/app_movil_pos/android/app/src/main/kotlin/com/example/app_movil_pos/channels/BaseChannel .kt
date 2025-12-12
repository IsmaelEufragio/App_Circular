// package com.tuapp.channels

// import io.flutter.plugin.common.MethodCall
// import io.flutter.plugin.common.MethodChannel

// abstract class BaseChannel {
//     abstract val channelName: String
    
//     // Método para manejar las llamadas
//     abstract fun handleMethodCall(call: MethodCall, result: MethodChannel.Result)
    
//     // Método helper para parsear argumentos
//     protected fun <T> getArgument(call: MethodCall, key: String, defaultValue: T? = null): T? {
//         val args = call.arguments as? Map<*, *>
//         return args?.get(key) as? T ?: defaultValue
//     }
// }