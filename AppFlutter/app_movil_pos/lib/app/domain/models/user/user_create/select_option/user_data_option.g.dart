// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataOptionImpl _$$UserDataOptionImplFromJson(Map<String, dynamic> json) =>
    _$UserDataOptionImpl(
      departamentos: (json['departamentos'] as List<dynamic>)
          .map((e) => Department.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoriaNegocios: (json['categoriaNegocios'] as List<dynamic>)
          .map((e) => BusinessCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserDataOptionImplToJson(
        _$UserDataOptionImpl instance) =>
    <String, dynamic>{
      'departamentos': instance.departamentos,
      'categoriaNegocios': instance.categoriaNegocios,
    };
