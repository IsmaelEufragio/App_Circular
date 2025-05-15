import '../../../domain/models/user/user.dart';
import '../../http/http.dart';
import '../local/session_service.dart';

class AccountServices {
  AccountServices(this._http, this._sessionSevices);

  final Http _http;
  final SessionSevices _sessionSevices;
  //final LanguageService _languageService;

  Future<User?> getAccount() async {
    final accountId = await _sessionSevices.accountId ?? '';
    final sessionId = await _sessionSevices.sessionId ?? '';

    final result = await _http.request(
      '/account/account_id=$accountId',
      queryParameters: {'session_id': sessionId},
      onSucces: (json) {
        return User.fromJson(json);
      },
    );

    return result.when(
      left: (_) => null,
      right: (user) => user,
    );
  }
}
