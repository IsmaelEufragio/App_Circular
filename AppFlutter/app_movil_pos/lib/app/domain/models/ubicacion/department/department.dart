import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';
import '../municipality/municipality.dart';

part 'department.freezed.dart';
part 'department.g.dart';

@freezed
class Department with _$Department {
  const factory Department({
    required String id,
    required String nombre,
    required List<Municipality> municipios,
  }) = _Department;

  factory Department.fromJson(Json json) => _$DepartmentFromJson(json);
  const Department._();
}
