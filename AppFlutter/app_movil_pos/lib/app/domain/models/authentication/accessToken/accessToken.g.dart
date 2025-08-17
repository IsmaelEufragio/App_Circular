// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccessTokenImpl _$$AccessTokenImplFromJson(Map<String, dynamic> json) =>
    _$AccessTokenImpl(
      tokenAccess: json['tokenAccess'] as String,
      expira: _fromJson(json['expira'] as String),
    );

Map<String, dynamic> _$$AccessTokenImplToJson(_$AccessTokenImpl instance) =>
    <String, dynamic>{
      'tokenAccess': instance.tokenAccess,
      'expira': _toJson(instance.expira),
    };
