import '../../../domain/models/user/user/user.dart';
import '../../http/http.dart';

class AccountServices {
  AccountServices(this._http);

  final Http _http;

  Future<User?> getAccount() async {
    String usuarioQuery = '''
  query{
    usuario{
      id
      idUserPrincipal
      identidad
      usuarioPrincipal
      nombreUsuario
      correo
      despcripcion
      fecebook
      informacionUnica{
        id
        nombre
        rutaDelLogo
        rutaDeLaPaginaWeb
      }
      telefonos{
        telefono
      }
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
