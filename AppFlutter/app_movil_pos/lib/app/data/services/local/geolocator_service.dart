//import 'package:geolocator/geolocator.dart';

import 'package:flutter/services.dart';

class GeolocatorService {
  static const platform = MethodChannel('com.example.device/infrared');

  Future<void> checkPermissions() async {
    try {
      final String result =
          await platform.invokeMethod('checkLocationPermissions');
      print('Permisos: $result');
    } on PlatformException catch (e) {
      print('Error permisos: ${e.message}');
    }
  }

  Future<String> getCurrentLocation() async {
    try {
      final dynamic result = await platform.invokeMethod('getCurrentLocation');

      // Convertir a Map<String, dynamic>
      final Map<String, dynamic> locationInfo =
          Map<String, dynamic>.from(result);
      return 'Latitud: ${locationInfo['latitude']}, Longitud: ${locationInfo['longitude']}';
    } on PlatformException catch (e) {
      return 'Error: ${e.message}';
    }
  }

  Future<void> openAppSettings() async {
    try {
      await platform.invokeMethod('openAppSettings');
    } on PlatformException catch (e) {
      print('Error abriendo configuración: ${e.message}');
    }
  }
}
