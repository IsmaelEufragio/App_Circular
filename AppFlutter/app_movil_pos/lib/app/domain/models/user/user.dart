import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';
import 'claim.dart';
import 'rol.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String identidad,
    required bool usuarioPrincipal,
    required String nombreUsuario,
    required String correo,
    required List<Rol> roles,
    required List<Claim> claims,
  }) = _User;

  factory User.fromJson(Json json) => _$UserFromJson(json);
  const User._();
}
