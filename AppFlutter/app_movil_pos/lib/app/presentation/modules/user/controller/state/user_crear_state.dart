import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_crear_state.freezed.dart';

@freezed
class UserCrearState with _$UserCrearState {
  factory UserCrearState({
    @Default('') String nombre,
    @Default('') String descripcion,
    @Default('') String rtn,
    @Default('') String rtnPersonal,
    @Default(0) int IdRubro,
  }) = _UserCrearState;
}
