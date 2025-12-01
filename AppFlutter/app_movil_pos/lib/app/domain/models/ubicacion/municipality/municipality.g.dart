// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'municipality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MunicipalityImpl _$$MunicipalityImplFromJson(Map<String, dynamic> json) =>
    _$MunicipalityImpl(
      id: json['id'] as String,
      descripcion: json['descripcion'] as String,
      lugares: (json['lugares'] as List<dynamic>)
          .map((e) => Place.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MunicipalityImplToJson(_$MunicipalityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'descripcion': instance.descripcion,
      'lugares': instance.lugares,
    };
