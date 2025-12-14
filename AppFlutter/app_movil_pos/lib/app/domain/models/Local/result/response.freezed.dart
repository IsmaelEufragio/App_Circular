// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Response<T> _$ResponseFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _Response<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$Response<T> {
  bool get success => throw _privateConstructorUsedError;
  T get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this Response to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResponseCopyWith<T, Response<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseCopyWith<T, $Res> {
  factory $ResponseCopyWith(
          Response<T> value, $Res Function(Response<T>) then) =
      _$ResponseCopyWithImpl<T, $Res, Response<T>>;
  @useResult
  $Res call({bool success, T data, String? message});
}

/// @nodoc
class _$ResponseCopyWithImpl<T, $Res, $Val extends Response<T>>
    implements $ResponseCopyWith<T, $Res> {
  _$ResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResponseImplCopyWith<T, $Res>
    implements $ResponseCopyWith<T, $Res> {
  factory _$$ResponseImplCopyWith(
          _$ResponseImpl<T> value, $Res Function(_$ResponseImpl<T>) then) =
      __$$ResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool success, T data, String? message});
}

/// @nodoc
class __$$ResponseImplCopyWithImpl<T, $Res>
    extends _$ResponseCopyWithImpl<T, $Res, _$ResponseImpl<T>>
    implements _$$ResponseImplCopyWith<T, $Res> {
  __$$ResponseImplCopyWithImpl(
      _$ResponseImpl<T> _value, $Res Function(_$ResponseImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$ResponseImpl<T>(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ResponseImpl<T> implements _Response<T> {
  const _$ResponseImpl(
      {required this.success, required this.data, this.message});

  factory _$ResponseImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ResponseImplFromJson(json, fromJsonT);

  @override
  final bool success;
  @override
  final T data;
  @override
  final String? message;

  @override
  String toString() {
    return 'Response<$T>(success: $success, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseImpl<T> &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, const DeepCollectionEquality().hash(data), message);

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseImplCopyWith<T, _$ResponseImpl<T>> get copyWith =>
      __$$ResponseImplCopyWithImpl<T, _$ResponseImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _Response<T> implements Response<T> {
  const factory _Response(
      {required final bool success,
      required final T data,
      final String? message}) = _$ResponseImpl<T>;

  factory _Response.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ResponseImpl<T>.fromJson;

  @override
  bool get success;
  @override
  T get data;
  @override
  String? get message;

  /// Create a copy of Response
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResponseImplCopyWith<T, _$ResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
