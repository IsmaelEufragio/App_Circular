import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../typedefs.dart';
import '../../../ubicacion/department/department.dart';
import '../../business_category/business_category.dart';

part 'user_data_option.freezed.dart';
part 'user_data_option.g.dart';

@freezed
class UserDataOption with _$UserDataOption {
  const factory UserDataOption({
    required List<Department> departamentos,
    required List<BusinessCategory> categoriaNegocios,
  }) = _UserDataOption;

  factory UserDataOption.fromJson(Json json) => _$UserDataOptionFromJson(json);
  const UserDataOption._();
}
