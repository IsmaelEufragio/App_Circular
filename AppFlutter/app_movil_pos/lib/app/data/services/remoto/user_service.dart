import '../../../domain/models/user/user_create/select_option/user_data_option.dart';
import '../../http/http.dart';

class UserService {
  UserService(this._http);
  final Http _http;

  Future<UserDataOption?> getUserDataOption() async {
    String userDataOptionQuery = '''query{
      categoriaNegocios{
        id
        descripcion
      }
      departamentos{
        id
        nombre
        municipios{
          id
          descripcion
          lugares{
            id
            descripcion
            colonias{
              id
              nombre
            }
          }
        }
      }
    }''';
    final resutlGraphql = await _http.requestGraphQL(
      query: userDataOptionQuery,
      authentication: false,
      onSucces: (json) {
        final option = UserDataOption.fromJson(json);
        return option;
      },
    );

    return resutlGraphql.when(
      left: (_) => null,
      right: (option) => option,
    );
  }
}
