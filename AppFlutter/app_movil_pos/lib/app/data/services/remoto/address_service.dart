import '../../http/http.dart';

class AddressService {
  AddressService(this._http);

  final Http _http;

  Future<String> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    final address = await _http.request(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1',
      method: HttpMethod.get,
      headers: {'User-Agent': 'AppCircular/1.0 (josueEufragio93@gmail.com)'},
      authentication: false,
      onSucces: (responseBody) {
        final json = responseBody as Map;
        return json['display_name'] as String;
      },
    );

    return address.when(left: (_) => '', right: (address) => address);
  }
}
