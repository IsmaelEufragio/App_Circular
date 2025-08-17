import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/models/authentication/accessToken/accessToken.dart';
import '../../../domain/models/authentication/refresToken/refresToken.dart';

const _refresToken = 'refresToken';
const _accessToken = 'accessToken';
const _password = 'password';
const _correo = 'correo';
const _rememberCredetial = 'rememberCredetial';

class SessionSevices {
  SessionSevices(this._securestorage);

  final FlutterSecureStorage _securestorage;

  Future<RefresToken?> get refresToken async {
    final refresTokenJson = await _securestorage.read(key: _refresToken);

    if (refresTokenJson == null) {
      return null;
    }
    final refresTokenMap = jsonDecode(refresTokenJson) as Map<String, dynamic>;
    return RefresToken.fromJson(refresTokenMap);
  }

  Future<AccessToken?> get accessToken async {
    final accessToken = await _securestorage.read(key: _accessToken);
    if (accessToken == null) {
      return null;
    }
    final accessTokenMap = jsonDecode(accessToken) as Map<String, dynamic>;
    return AccessToken.fromJson(accessTokenMap);
  }

  Future<String?> get correo {
    return _securestorage.read(key: _correo);
  }

  Future<String?> get password {
    return _securestorage.read(key: _password);
  }

  Future<bool> get rememberCredential async {
    final remember = await _securestorage.read(key: _rememberCredetial);
    return remember != null;
  }

  Future<void> saveRefresToken(RefresToken refresToken) {
    final data = {
      'refresToken': refresToken.refresToken,
      'expira': refresToken.expira.toIso8601String(),
    };
    final jsonString = jsonEncode(data);
    return _securestorage.write(
      key: _refresToken,
      value: jsonString,
    );
  }

  Future<void> saveAccessToken(AccessToken accessToken) {
    final data = {
      'tokenAccess': accessToken.tokenAccess,
      'expira': accessToken.expira.toIso8601String(),
    };
    final jsonString = jsonEncode(data);
    return _securestorage.write(
      key: _accessToken,
      value: jsonString,
    );
  }

  Future<void> saveCredentials(
      String correo, String password, bool rememberCredentials) {
    _securestorage.write(key: _correo, value: correo);
    _securestorage.write(key: _password, value: password);
    return _securestorage.write(
        key: _rememberCredetial, value: rememberCredentials.toString());
  }

  Future<void> signOut() {
    return _securestorage.deleteAll();
  }

  Future<void> deleteCredential() {
    _securestorage.delete(key: _password);
    _securestorage.delete(key: _correo);
    return _securestorage.delete(key: _rememberCredetial);
  }
}
