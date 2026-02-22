abstract class AddressRepository {
  Future<String> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  });
}
