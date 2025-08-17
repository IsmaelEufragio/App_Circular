import 'package:freezed_annotation/freezed_annotation.dart';

part 'rol.freezed.dart';
part 'rol.g.dart';

@freezed
class Rol with _$Rol {
  const factory Rol({
    required String nombre,
    required String nombreNormalizado,
  }) = _Rol;

  factory Rol.fromJson(Map<String, dynamic> json) => _$RolFromJson(json);
}
