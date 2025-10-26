import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_category.freezed.dart';
part 'business_category.g.dart';

@freezed
class BusinessCategory with _$BusinessCategory {
  factory BusinessCategory({
    required String id,
    required String descripcion,
  }) = _BusinessCategory;

  factory BusinessCategory.fromJson(Map<String, dynamic> json) =>
      _$BusinessCategoryFromJson(json);
}
