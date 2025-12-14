//import 'package:geolocator/geolocator.dart';

import 'package:flutter/services.dart';

class GeolocatorService {
  static const localtionChannel = MethodChannel('com.example.device/location');

  Future<void> checkPermissions() async {
    try {
      // final String result =
      //     await platform.invokeMethod('checkLocationPermissions');
      final dynamic result =
          await localtionChannel.invokeMethod('getCurrentLocation');

      // Convertir a Map<String, dynamic>
      final Map<String, dynamic> locationInfo =
          Map<String, dynamic>.from(result);
      //return 'Latitud: ${locationInfo['latitude']}, Longitud: ${locationInfo['longitude']}';
      print(locationInfo['message']);
    } on PlatformException catch (e) {
      print('Error permisos: ${e.message}');
    }
  }

  Future<String> getCurrentLocation() async {
    try {
      final dynamic result =
          await localtionChannel.invokeMethod('getCurrentLocation');

      final Map<String, dynamic> locationInfo =
          Map<String, dynamic>.from(result);
      //return 'Latitud: ${locationInfo['latitude']}, Longitud: ${locationInfo['longitude']}';
      return locationInfo['message'];
    } on PlatformException catch (e) {
      return 'Error: ${e.message}';
    }
  }

  Future<void> openAppSettings() async {
    try {
      await localtionChannel.invokeMethod('openAppSettings');
    } on PlatformException catch (e) {
      print('Error abriendo configuración: ${e.message}');
    }
  }
}
