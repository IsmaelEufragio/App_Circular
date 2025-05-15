import '../../domain/either/either.dart';
import '../../domain/failures/sign_in/sign_in_failure.dart';
import '../../domain/models/user/user.dart';
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
    final sessionId = await _sessionSevices.sessionId;
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
      String username, String password) async {
    final requestToken = await _authenticationService.createRequestToken();
    return requestToken.when(
      left: (failure) async => Either.left(failure),
      right: (token) async {
        final requesLogin = await _authenticationService.CreateSessionWithLogin(
          username: username,
          password: password,
          token: token,
        );
        return requesLogin.when(
            left: (failure) async => Either.left(failure),
            right: (newRequestToken) async {
              final sessionId =
                  await _authenticationService.createSession(newRequestToken);

              return sessionId.when(
                left: (failure) async => Either.left(failure),
                right: (sessionId) async {
                  _sessionSevices.saveSessionId(sessionId);
                  final user = await _accountServices.getAccount();
                  if (user == null) {
                    return Either.left(const SignInFailure.unknown());
                  }
                  return Either.right(user);
                },
              );
            });
      },
    );
  }

  @override
  Future<void> signOut() {
    return _sessionSevices.signOut();
  }
}
