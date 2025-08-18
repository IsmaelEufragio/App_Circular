import '../../domain/either/either.dart';
import '../../domain/failures/sign_in/sign_in_failure.dart';
import '../../domain/models/user/user/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../services/local/session_service.dart';
import '../services/remoto/account_service.dart';
import '../services/remoto/authentication_service.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
    this._authenticationService,
    this._sessionSevices,
    this._accountServices,
  );

  final AuthenticationService _authenticationService;
  final SessionSevices _sessionSevices;
  final AccountServices _accountServices;

  @override
  Future<bool> get isSignedIn async {
    return await _authenticationService.isSignedIn();
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
      String username, String password, bool rememberCredentials) async {
    final requestTokenRefres = await _authenticationService
        .createRequestTokenRefres(username: username, password: password);
    return requestTokenRefres.when(
      left: (failure) async => Either.left(failure),
      right: (token) async {
        _sessionSevices.saveRefresToken(token);
        if (rememberCredentials) {
          _sessionSevices.saveCredentials(
              username, password, rememberCredentials);
        } else {
          _sessionSevices.deleteCredential();
        }
        final requestTokenAccess = await _authenticationService
            .createRequestTokenAccess(refresToken: token.refresToken);
        return requestTokenAccess.when(
          left: (failure) async => Either.left(failure),
          right: (accessToken) async {
            _sessionSevices.saveAccessToken(accessToken);
            final user = await _accountServices.getAccount();
            if (user == null) {
              return Either.left(const SignInFailure.notFound());
            }
            return Either.right(user);
          },
        );
      },
    );
  }

  @override
  Future<void> signOut() {
    return _sessionSevices.signOut();
  }
}
