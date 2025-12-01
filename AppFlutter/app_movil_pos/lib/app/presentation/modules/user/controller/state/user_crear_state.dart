import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/ubicacion/department/department.dart';
import '../../../../../domain/models/user/business_category/business_category.dart';

part 'user_crear_state.freezed.dart';

@freezed
class UserCrearState with _$UserCrearState {
  factory UserCrearState({
    @Default('') String nombre,
    @Default('') String descripcion,
    @Default('') String rtn,
    @Default('') String rtnPersonal,
    @Default('') String telefono,
    @Default('') String email,
    @Default('') String facebook,
    @Default('') String instagram,
    @Default(false) bool whatsapp,
    @Default(false) bool domicilio,
    @Default([]) List<BusinessCategory> selectedCategories,
    @Default([]) List<BusinessCategory> optiondCategories,
    @Default([]) List<Department> departamentos,
    @Default('') String selectedDepartamentoId,
    @Default('') String selectedMunicipioId,
    @Default('') String selectedLugarId,
  }) = _UserCrearState;
}
