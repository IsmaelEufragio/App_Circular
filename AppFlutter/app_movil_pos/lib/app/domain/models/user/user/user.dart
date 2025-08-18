import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';
import '../claim/claim.dart';
import '../phone/phone.dart';
import '../rol/rol.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String despcripcion,
    required String identidad,
    required bool usuarioPrincipal,
    required String correo,
    required String fecebook,
    required List<Rol> roles,
    required List<Claim> claims,
    required List<Phone> telefonos,
    @JsonKey(name: 'nombreUsuario') required String nombre,
    @JsonKey(name: 'idUserPrincipal') required String idPrincipal,
    @JsonKey(readValue: readLogoValue) required String rutaDelLogo,
    @JsonKey(readValue: readNombreValue) required String nombreComercial,
  }) = _User;

  factory User.fromJson(Json json) => _$UserFromJson(json);
  const User._();
}

Object? readLogoValue(Map map, String _) {
  return map['informacionUnica']?['rutaDelLogo'];
}

Object? readNombreValue(Map map, String _) {
  return map['informacionUnica']?['rutaDelLogo'];
}
