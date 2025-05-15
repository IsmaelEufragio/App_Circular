import '../../../domain/either/either.dart';
import '../../../domain/failures/sign_in/sign_in_failure.dart';
import '../../http/http.dart';

class AuthenticationService {
  AuthenticationService(this._http);

  final Http _http;

  Either<SignInFailure, String> _handleFailure(HttpFailure failure) {
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

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final result = await _http.request(
      '/authentication/token/new',
      onSucces: (responseBody) {
        final json = responseBody as Map;
        return json['request_token'] as String;
      },
    );

    return result.when(
      left: _handleFailure,
      right: (responseBody) {
        return Either.right(responseBody);
      },
    );
  }

  Future<Either<SignInFailure, String>> CreateSessionWithLogin(
      {required String username,
      required String password,
      required String token}) async {
    final result = await _http.request(
      '/authentication/token/validate_with_login',
      method: HttpMethod.post,
      body: {
        'username': username,
        'password': password,
        'request_token': token,
      },
      onSucces: (responseBody) {
        final json = responseBody as Map;
        return json['request_token'] as String;
      },
    );

    return result.when(
      left: _handleFailure,
      right: (responseBody) {
        return Either.right(responseBody);
      },
    );
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    final result = await _http.request(
      '/authentication/session/new',
      method: HttpMethod.post,
      body: {
        'request_token': requestToken,
      },
      onSucces: (responseBody) {
        final json = responseBody as Map;
        return json['session_id'] as String;
      },
    );

    return result.when(
      left: _handleFailure,
      right: (responseBody) {
        return Either.right(responseBody);
      },
    );
  }
}
