// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refresToken.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RefresToken _$RefresTokenFromJson(Map<String, dynamic> json) {
  return _RefresToken.fromJson(json);
}

/// @nodoc
mixin _$RefresToken {
  String get refresToken => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime get expira => throw _privateConstructorUsedError;

  /// Serializes this RefresToken to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RefresToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RefresTokenCopyWith<RefresToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefresTokenCopyWith<$Res> {
  factory $RefresTokenCopyWith(
          RefresToken value, $Res Function(RefresToken) then) =
      _$RefresTokenCopyWithImpl<$Res, RefresToken>;
  @useResult
  $Res call(
      {String refresToken,
      @JsonKey(fromJson: _fromJson, toJson: _toJson) DateTime expira});
}

/// @nodoc
class _$RefresTokenCopyWithImpl<$Res, $Val extends RefresToken>
    implements $RefresTokenCopyWith<$Res> {
  _$RefresTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RefresToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refresToken = null,
    Object? expira = null,
  }) {
    return _then(_value.copyWith(
      refresToken: null == refresToken
          ? _value.refresToken
          : refresToken // ignore: cast_nullable_to_non_nullable
              as String,
      expira: null == expira
          ? _value.expira
          : expira // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RefresTokenImplCopyWith<$Res>
    implements $RefresTokenCopyWith<$Res> {
  factory _$$RefresTokenImplCopyWith(
          _$RefresTokenImpl value, $Res Function(_$RefresTokenImpl) then) =
      __$$RefresTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String refresToken,
      @JsonKey(fromJson: _fromJson, toJson: _toJson) DateTime expira});
}

/// @nodoc
class __$$RefresTokenImplCopyWithImpl<$Res>
    extends _$RefresTokenCopyWithImpl<$Res, _$RefresTokenImpl>
    implements _$$RefresTokenImplCopyWith<$Res> {
  __$$RefresTokenImplCopyWithImpl(
      _$RefresTokenImpl _value, $Res Function(_$RefresTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of RefresToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refresToken = null,
    Object? expira = null,
  }) {
    return _then(_$RefresTokenImpl(
      refresToken: null == refresToken
          ? _value.refresToken
          : refresToken // ignore: cast_nullable_to_non_nullable
              as String,
      expira: null == expira
          ? _value.expira
          : expira // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RefresTokenImpl implements _RefresToken {
  const _$RefresTokenImpl(
      {required this.refresToken,
      @JsonKey(fromJson: _fromJson, toJson: _toJson) required this.expira});

  factory _$RefresTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefresTokenImplFromJson(json);

  @override
  final String refresToken;
  @override
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime expira;

  @override
  String toString() {
    return 'RefresToken(refresToken: $refresToken, expira: $expira)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefresTokenImpl &&
            (identical(other.refresToken, refresToken) ||
                other.refresToken == refresToken) &&
            (identical(other.expira, expira) || other.expira == expira));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, refresToken, expira);

  /// Create a copy of RefresToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefresTokenImplCopyWith<_$RefresTokenImpl> get copyWith =>
      __$$RefresTokenImplCopyWithImpl<_$RefresTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RefresTokenImplToJson(
      this,
    );
  }
}

abstract class _RefresToken implements RefresToken {
  const factory _RefresToken(
      {required final String refresToken,
      @JsonKey(fromJson: _fromJson, toJson: _toJson)
      required final DateTime expira}) = _$RefresTokenImpl;

  factory _RefresToken.fromJson(Map<String, dynamic> json) =
      _$RefresTokenImpl.fromJson;

  @override
  String get refresToken;
  @override
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime get expira;

  /// Create a copy of RefresToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefresTokenImplCopyWith<_$RefresTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
