//import 'package:geolocator/geolocator.dart';

import 'package:flutter/services.dart';

import '../../../domain/enums.dart';
import '../../../domain/models/Local/geolocator/geolocator.dart';
import '../../../domain/models/Local/result/response.dart';
import '../../../domain/typedefs.dart';

class GeolocatorService {
  static const localtionChannel = MethodChannel('com.example.device/location');

  Future<Permisos> checkPermissions() async {
    try {
      final dynamic result =
          await localtionChannel.invokeMethod('checkLocationPermissions');

      final Json jsonMap = Json.from(result as Map);
      if (jsonMap['success'] == true) {
        final data = jsonMap['data'];
        if (data != null && data['status'] != null) {
          return Permisos.fromValue(data['status'] as String);
        }
        throw Permisos.requestPermission;
      }
      return Permisos.requestPermission;
    } on PlatformException catch (e) {
      print('Error permisos: ${e.message}');
      return Permisos.requestPermission;
    }
  }

  Future<Response<Geolocator>> getCurrentLocation() async {
    try {
      final dynamic result =
          await localtionChannel.invokeMethod('getCurrentLocation');

      final Json jsonMap = Json.from(result as Map);

      if (jsonMap['data'] is Map) {
        jsonMap['data'] = Json.from(jsonMap['data'] as Map);
      }

      return Response<Geolocator>.fromJson(
        jsonMap,
        (json) => Geolocator.fromJson(json as Json),
      );
    } on PlatformException catch (e) {
      print('Error al obtener la ubicacion: ${e.message}');
      return Response<Geolocator>(
        success: false,
        message: 'Error: ${e.message}',
        data: const Geolocator(
          latitude: 0.0,
          longitude: 0.0,
          accuracy: 0.0,
          formatted: '',
        ),
      );
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
