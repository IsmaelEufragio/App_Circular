import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';

part 'business_category.freezed.dart';
part 'business_category.g.dart';

@freezed
class BusinessCategory with _$BusinessCategory {
  factory BusinessCategory({
    required String id,
    required String descripcion,
  }) = _BusinessCategory;

  factory BusinessCategory.fromJson(Json json) =>
      _$BusinessCategoryFromJson(json);
}
