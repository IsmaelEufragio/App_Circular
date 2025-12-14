// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResponseImpl<T> _$$ResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$ResponseImpl<T>(
      success: json['success'] as bool,
      data: fromJsonT(json['data']),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ResponseImplToJson<T>(
  _$ResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'data': toJsonT(instance.data),
      'message': instance.message,
    };
