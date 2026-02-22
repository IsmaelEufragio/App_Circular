import '../../../domain/models/user/user/user.dart';
import '../../http/http.dart';

class AccountServices {
  AccountServices(this._http);

  final Http _http;

  Future<bool> createUser() async {
    final result = await _http.request('/Usuario/CrearUsuario',
        method: HttpMethod.post, authentication: false, onSucces: (_) => false);
    return result.when(
      left: (_) => false,
      right: (value) => value,
    );
  }

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
        idTipoTelefono
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
        try {
          final user = User.fromJson(json['usuario']);
          return user;
        } catch (e) {
          return null;
        }
      },
    );
    return resutlGraphql.when(
      left: (_) => null,
      right: (user) => user,
    );
  }
}
