// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Scan _$ScanFromJson(Map<String, dynamic> json) {
  return _Scan.fromJson(json);
}

/// @nodoc
mixin _$Scan {
  String get qscCode => throw _privateConstructorUsedError;

  /// Serializes this Scan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Scan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanCopyWith<Scan> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanCopyWith<$Res> {
  factory $ScanCopyWith(Scan value, $Res Function(Scan) then) =
      _$ScanCopyWithImpl<$Res, Scan>;
  @useResult
  $Res call({String qscCode});
}

/// @nodoc
class _$ScanCopyWithImpl<$Res, $Val extends Scan>
    implements $ScanCopyWith<$Res> {
  _$ScanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Scan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? qscCode = null,
  }) {
    return _then(_value.copyWith(
      qscCode: null == qscCode
          ? _value.qscCode
          : qscCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScanImplCopyWith<$Res> implements $ScanCopyWith<$Res> {
  factory _$$ScanImplCopyWith(
          _$ScanImpl value, $Res Function(_$ScanImpl) then) =
      __$$ScanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String qscCode});
}

/// @nodoc
class __$$ScanImplCopyWithImpl<$Res>
    extends _$ScanCopyWithImpl<$Res, _$ScanImpl>
    implements _$$ScanImplCopyWith<$Res> {
  __$$ScanImplCopyWithImpl(_$ScanImpl _value, $Res Function(_$ScanImpl) _then)
      : super(_value, _then);

  /// Create a copy of Scan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? qscCode = null,
  }) {
    return _then(_$ScanImpl(
      qscCode: null == qscCode
          ? _value.qscCode
          : qscCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScanImpl implements _Scan {
  const _$ScanImpl({required this.qscCode});

  factory _$ScanImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanImplFromJson(json);

  @override
  final String qscCode;

  @override
  String toString() {
    return 'Scan(qscCode: $qscCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanImpl &&
            (identical(other.qscCode, qscCode) || other.qscCode == qscCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, qscCode);

  /// Create a copy of Scan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanImplCopyWith<_$ScanImpl> get copyWith =>
      __$$ScanImplCopyWithImpl<_$ScanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanImplToJson(
      this,
    );
  }
}

abstract class _Scan implements Scan {
  const factory _Scan({required final String qscCode}) = _$ScanImpl;

  factory _Scan.fromJson(Map<String, dynamic> json) = _$ScanImpl.fromJson;

  @override
  String get qscCode;

  /// Create a copy of Scan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanImplCopyWith<_$ScanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
