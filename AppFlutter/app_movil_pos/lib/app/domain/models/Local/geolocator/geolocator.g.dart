// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GeolocatorImpl _$$GeolocatorImplFromJson(Map<String, dynamic> json) =>
    _$GeolocatorImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toDouble(),
      formatted: json['formatted'] as String,
    );

Map<String, dynamic> _$$GeolocatorImplToJson(_$GeolocatorImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'formatted': instance.formatted,
    };
