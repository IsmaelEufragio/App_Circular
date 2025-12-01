// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DepartmentImpl _$$DepartmentImplFromJson(Map<String, dynamic> json) =>
    _$DepartmentImpl(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      municipios: (json['municipios'] as List<dynamic>)
          .map((e) => Municipality.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DepartmentImplToJson(_$DepartmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'municipios': instance.municipios,
    };
