import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';
const _accountKey = 'accountId';

class SessionSevices {
  SessionSevices(this._securestorage);

  final FlutterSecureStorage _securestorage;

  Future<String?> get sessionId {
    return _securestorage.read(key: _key);
  }

  Future<String?> get accountId {
    return _securestorage.read(key: _accountKey);
  }

  Future<void> saveSessionId(String sessionId) {
    return _securestorage.write(
      key: _key,
      value: sessionId,
    );
  }

  Future<void> saveAccountId(String accountId) {
    return _securestorage.write(
      key: _accountKey,
      value: accountId,
    );
  }

  Future<void> signOut() {
    return _securestorage.deleteAll();
  }
}
