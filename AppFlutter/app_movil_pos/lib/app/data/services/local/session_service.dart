import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _refresToken = 'refresToken';
const _accessToken = 'accessToken';

class SessionSevices {
  SessionSevices(this._securestorage);

  final FlutterSecureStorage _securestorage;

  Future<String?> get refresToken {
    return _securestorage.read(key: _refresToken);
  }

  Future<String?> get accessToken {
    return _securestorage.read(key: _accessToken);
  }

  Future<void> saveRefresToken(String refresToken) {
    return _securestorage.write(
      key: _refresToken,
      value: refresToken,
    );
  }

  Future<void> saveAccessToken(String accessToken) {
    return _securestorage.write(
      key: _accessToken,
      value: accessToken,
    );
  }

  Future<void> signOut() {
    return _securestorage.deleteAll();
  }
}
