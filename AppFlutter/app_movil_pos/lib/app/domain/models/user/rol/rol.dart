import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';

part 'rol.freezed.dart';
part 'rol.g.dart';

@freezed
class Rol with _$Rol {
  const factory Rol({
    required String nombre,
    required String nombreNormalizado,
  }) = _Rol;

  factory Rol.fromJson(Json json) => _$RolFromJson(json);
}
