import '../../../domain/models/user/user.dart';
import '../../http/http.dart';
import '../local/session_service.dart';

class AccountServices {
  AccountServices(this._http, this._sessionSevices);

  final Http _http;
  final SessionSevices _sessionSevices;

  Future<User?> getAccount() async {
    String usuarioQuery = '''
  query{
    usuario{
      identidad
      usuarioPrincipal
      nombreUsuario
      correo
      roles{
        nombre
        nombreNormalizado
      }
      claims{
        tipo
        valor
      }
    }
  }
 ''';
    final resutlGraphql = await _http.requestGraphQL(
      query: usuarioQuery,
      authentication: true,
      onSucces: (json) {
        final user = User.fromJson(json['usuario']);
        return user;
      },
    );
    return resutlGraphql.when(
      left: (_) => null,
      right: (user) => user,
    );
  }
}
