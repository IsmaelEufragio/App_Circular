import '../enums.dart';
import '../models/Local/geolocator/geolocator.dart';
import '../models/Local/result/response.dart';

abstract class GeolocatorRepository {
  Future<Permisos> checkPermissions();
  Future<Response<Geolocator>> getCurrentLocation();
  Future<void> openAppSettings();
}
