import 'dart:convert';

import '../../../domain/models/user/user_create/select_option/user_data_option.dart';
import '../../../domain/models/user/user_create/user_create_request.dart';
import '../../http/http.dart';

class UserService {
  UserService(this._http);
  final Http _http;

  Future<void> createUser({
    required UserCreateRequest request,
    required void Function(dynamic responseBody) onSucces,
  }) async {
    await _http.request(
      '/Usuario/CrearUsuario',
      method: HttpMethod.post,
      isMultipart: true,
      authentication: false,
      multipartData: MultipartData(
        fields: {
          'UserTypeId': request.idTipoUsuario,
          'TypeOfIdentity': request.idTipoIdentidad,
          'SubPlaceId': request.coloniaId,
          'Identity': request.rtn,
          'BusinessName': request.nombreComercial,
          'UserName': request.nombreUsuario,
          'Correo': request.email,
          'Password': request.password,
          'Description': request.descripcion,
          'Latitud': request.latitude.toString(),
          'Longitub': request.longitude.toString(),
          'Facebook': request.facebook ?? '',
          'Instagram': request.instagram ?? '',
          'WebsitePath':
              request.whatsapp ? 'https://wa.me/${request.telefono}' : '',
          'WhatsApp': request.whatsapp.toString(),
          'Shipping': request.domicilio.toString(),
          'Schedule':
              jsonEncode(request.horarios.map((h) => h.toJson()).toList()),
          'Category': jsonEncode(
              request.categorias.map((c) => {'catg_Id': c.id}).toList()),
          'Telephone': jsonEncode([
            {
              'idTipoTelefono': '56c02185-4892-4c54-b8d3-7f93cdf241ac',
              'telefono': request.telefono,
            }
          ]),
        },
        files: [
          MultipartFileData(
            fieldName: 'logo',
            filePath: request.logo.path,
          ),
        ],
      ),
      onSucces: onSucces,
    );
  }

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
