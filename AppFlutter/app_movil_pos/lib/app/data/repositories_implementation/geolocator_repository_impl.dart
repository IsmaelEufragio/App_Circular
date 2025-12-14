import '../../domain/enums.dart';
import '../../domain/models/Local/geolocator/geolocator.dart';
import '../../domain/models/Local/result/response.dart';
import '../../domain/repositories/geolocator_repository.dart';
import '../services/local/geolocator_service.dart';

class GeolocatorRepositoryImpl implements GeolocatorRepository {
  GeolocatorRepositoryImpl(this._geolocatorService);

  final GeolocatorService _geolocatorService;

  @override
  Future<Permisos> checkPermissions() async {
    return await _geolocatorService.checkPermissions();
  }

  @override
  Future<Response<Geolocator>> getCurrentLocation() async {
    return await _geolocatorService.getCurrentLocation();
  }

  @override
  Future<void> openAppSettings() async {
    await _geolocatorService.openAppSettings();
  }
}
