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
    final model = MultipartData(
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
      },
      files: [
        MultipartFileData(
          fieldName: 'logo',
          filePath: request.logo.path,
        ),
      ],
    );
    for (var i = 0; i < request.horarios.length; i++) {
      model.fields['Schedule[$i][DiaNumero]'] =
          request.horarios[i].diaNumero.toString();
      model.fields['Schedule[$i][HoraInicio]'] = request.horarios[i].horaInicio;
      model.fields['Schedule[$i][HoraFin]'] = request.horarios[i].horaFin;
    }
    for (var i = 0; i < request.categorias.length; i++) {
      model.fields['Category[$i][catg_Id]'] = request.categorias[i].id;
    }

    model.fields['Telephone[0][idTipoTelefono]'] =
        '56c02185-4892-4c54-b8d3-7f93cdf241ac';
    model.fields['Telephone[0][telefono]'] = request.telefono;

    await _http.request(
      '/Usuario/CrearUsuario',
      method: HttpMethod.post,
      isMultipart: true,
      authentication: false,
      multipartData: model,
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
