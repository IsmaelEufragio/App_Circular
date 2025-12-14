// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geolocator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Geolocator _$GeolocatorFromJson(Map<String, dynamic> json) {
  return _Geolocator.fromJson(json);
}

/// @nodoc
mixin _$Geolocator {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  String get formatted => throw _privateConstructorUsedError;

  /// Serializes this Geolocator to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Geolocator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeolocatorCopyWith<Geolocator> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeolocatorCopyWith<$Res> {
  factory $GeolocatorCopyWith(
          Geolocator value, $Res Function(Geolocator) then) =
      _$GeolocatorCopyWithImpl<$Res, Geolocator>;
  @useResult
  $Res call(
      {double latitude, double longitude, double accuracy, String formatted});
}

/// @nodoc
class _$GeolocatorCopyWithImpl<$Res, $Val extends Geolocator>
    implements $GeolocatorCopyWith<$Res> {
  _$GeolocatorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Geolocator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? formatted = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      formatted: null == formatted
          ? _value.formatted
          : formatted // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeolocatorImplCopyWith<$Res>
    implements $GeolocatorCopyWith<$Res> {
  factory _$$GeolocatorImplCopyWith(
          _$GeolocatorImpl value, $Res Function(_$GeolocatorImpl) then) =
      __$$GeolocatorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double latitude, double longitude, double accuracy, String formatted});
}

/// @nodoc
class __$$GeolocatorImplCopyWithImpl<$Res>
    extends _$GeolocatorCopyWithImpl<$Res, _$GeolocatorImpl>
    implements _$$GeolocatorImplCopyWith<$Res> {
  __$$GeolocatorImplCopyWithImpl(
      _$GeolocatorImpl _value, $Res Function(_$GeolocatorImpl) _then)
      : super(_value, _then);

  /// Create a copy of Geolocator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? formatted = null,
  }) {
    return _then(_$GeolocatorImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      formatted: null == formatted
          ? _value.formatted
          : formatted // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeolocatorImpl implements _Geolocator {
  const _$GeolocatorImpl(
      {required this.latitude,
      required this.longitude,
      required this.accuracy,
      required this.formatted});

  factory _$GeolocatorImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeolocatorImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double accuracy;
  @override
  final String formatted;

  @override
  String toString() {
    return 'Geolocator(latitude: $latitude, longitude: $longitude, accuracy: $accuracy, formatted: $formatted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeolocatorImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.formatted, formatted) ||
                other.formatted == formatted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, accuracy, formatted);

  /// Create a copy of Geolocator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeolocatorImplCopyWith<_$GeolocatorImpl> get copyWith =>
      __$$GeolocatorImplCopyWithImpl<_$GeolocatorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeolocatorImplToJson(
      this,
    );
  }
}

abstract class _Geolocator implements Geolocator {
  const factory _Geolocator(
      {required final double latitude,
      required final double longitude,
      required final double accuracy,
      required final String formatted}) = _$GeolocatorImpl;

  factory _Geolocator.fromJson(Map<String, dynamic> json) =
      _$GeolocatorImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get accuracy;
  @override
  String get formatted;

  /// Create a copy of Geolocator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeolocatorImplCopyWith<_$GeolocatorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
