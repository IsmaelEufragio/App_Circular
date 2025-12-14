import 'package:flutter/services.dart';

import '../../../domain/enums.dart';

class PrinterService {
  static const _channel = MethodChannel('com.example.device/printer');

  Future<bool> configLcd(ConfigLcd estado) async {
    try {
      final dynamic result = await _channel.invokeMethod('configLcd', {
        'parametro': estado.index,
      });
      print(result);
      if (result['success'] == true) {
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      print("Failed to configure LCD: '${e.message}'.");
      return false;
    }
  }
}
