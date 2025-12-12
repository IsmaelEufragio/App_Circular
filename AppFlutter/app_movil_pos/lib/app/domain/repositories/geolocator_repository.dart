abstract class GeolocatorRepository {
  Future<void> checkPermissions();
  Future<String> getCurrentLocation();
  Future<void> openAppSettings();
}
