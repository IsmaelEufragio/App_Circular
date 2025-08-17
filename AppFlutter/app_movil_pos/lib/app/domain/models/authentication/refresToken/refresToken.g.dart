// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RefresTokenImpl _$$RefresTokenImplFromJson(Map<String, dynamic> json) =>
    _$RefresTokenImpl(
      refresToken: json['refresToken'] as String,
      expira: _fromJson(json['expira'] as String),
    );

Map<String, dynamic> _$$RefresTokenImplToJson(_$RefresTokenImpl instance) =>
    <String, dynamic>{
      'refresToken': instance.refresToken,
      'expira': _toJson(instance.expira),
    };
