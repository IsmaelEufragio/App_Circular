import '../../domain/repositories/address_repository.dart';
import '../services/remoto/address_service.dart';

class AdressRepositoryImpl implements AddressRepository {
  AdressRepositoryImpl({required this.addressService});

  final AddressService addressService;
  @override
  Future<String> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) {
    return addressService.getAddressFromCoordinates(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
