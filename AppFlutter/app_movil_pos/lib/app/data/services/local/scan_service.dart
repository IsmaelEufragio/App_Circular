import 'dart:async';

import 'package:flutter/services.dart';

import '../../../domain/models/Local/Scan/scan.dart';
import '../../../domain/models/Local/result/response.dart';
import '../../../domain/typedefs.dart';

class ScanService {
  static const _channel = MethodChannel('com.example.device/scanner');

  // StreamController para enviar los resultados del escaneo a la UI
  final _scanResultController = StreamController<String>.broadcast();

  // Getter para exponer el Stream a la aplicación
  Stream<String> get scanResults => _scanResultController.stream;

  scannerService() {
    // 1. Establecer el MethodCallHandler para escuchar llamadas del nativo (invokeMethod)
    _channel.setMethodCallHandler(_nativeCallHandler);
  }

  // 2. Handler que procesa las llamadas desde Kotlin/Native
  Future<void> _nativeCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onScanDataReceived': //onScanDataReceived
        try {
          dynamic scanResult = call.arguments;
          print('Resultado del escaneo recibido: $scanResult');

          final Json jsonMap = Json.from(scanResult as Map);

          if (jsonMap['data'] is Map) {
            jsonMap['data'] = Json.from(jsonMap['data'] as Map);
          }

          var result = Response<Scan>.fromJson(
            jsonMap,
            (json) => Scan.fromJson(json as Json),
          );

          if (result.success) {
            _scanResultController.add(result.data.qscCode);
            //print('QSC Code emitido al stream: ${result.data.qscCode}');
          } else {
            print('Escaneo no exitoso: ${result.message}');
          }
        } catch (e, stackTrace) {
          print('Error procesando escaneo: $e');
          print('Stack trace: $stackTrace');
          // Opcionalmente, emite un error al stream
          _scanResultController.addError(e, stackTrace);
        }
        break;

      default:
        throw MissingPluginException(
            'ScannerMethodHandler no implementa el método ${call.method}');
    }
  }

  // 4. (Opcional) Función para disparar el escaneo desde Dart
  Future<bool> triggerScan() async {
    try {
      final dynamic result = await _channel.invokeMethod('triggerScan');
      if (result['success'] == true) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      print('Error al disparar el escaneo: ${e.message}');
      return false;
    }
  }

  // 5. Limpieza (Importante para evitar fugas de memoria)
  void dispose() {
    _scanResultController.close();
  }
}
