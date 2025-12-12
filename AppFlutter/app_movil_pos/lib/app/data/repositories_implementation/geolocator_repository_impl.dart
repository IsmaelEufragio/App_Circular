import '../../domain/repositories/geolocator_repository.dart';
import '../services/local/geolocator_service.dart';

class GeolocatorRepositoryImpl implements GeolocatorRepository {
  GeolocatorRepositoryImpl(this._geolocatorService);

  final GeolocatorService _geolocatorService;

  @override
  Future<void> checkPermissions() async {
    await _geolocatorService.checkPermissions();
  }

  @override
  Future<String> getCurrentLocation() async {
    return await _geolocatorService.getCurrentLocation();
  }

  @override
  Future<void> openAppSettings() async {
    await _geolocatorService.openAppSettings();
  }
}
