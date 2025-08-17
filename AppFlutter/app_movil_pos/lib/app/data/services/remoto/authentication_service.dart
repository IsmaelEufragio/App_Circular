import '../../../domain/either/either.dart';
import '../../../domain/failures/sign_in/sign_in_failure.dart';
import '../../../domain/models/authentication/accessToken/accessToken.dart';
import '../../../domain/models/authentication/refresToken/refresToken.dart';
import '../../http/http.dart';

class AuthenticationService {
  AuthenticationService(this._http);

  final Http _http;

  Either<SignInFailure, T> _handleFailure<T>(HttpFailure failure) {
    if (failure.statusCode != null) {
      switch (failure.statusCode) {
        case 401:
          if (failure.data is Map &&
              (failure.data as Map)['status_code'] == 32) {
            return Either.left(const SignInFailure.notVerified());
          }
          return Either.left(const SignInFailure.unauthorized());
        case 404:
          return Either.left(const SignInFailure.notFound());
        default:
          return Either.left(const SignInFailure.unknown());
      }
    }
    if (failure.exception is NetworkException) {
      return Either.left(const SignInFailure.network());
    }
    return Either.left(const SignInFailure.unknown());
  }

  Future<Either<SignInFailure, RefresToken>> createRequestTokenRefres({
    required String username,
    required String password,
  }) {
    return _http.createRequestTokenRefres(
        username: username, password: password);
  }

  Future<Either<SignInFailure, AccessToken>> createRequestTokenAccess(
      {required String refresToken}) {
    return _http.createRequestTokenAccess(refresToken: refresToken);
  }
}
