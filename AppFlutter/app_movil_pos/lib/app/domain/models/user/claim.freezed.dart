// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Claim _$ClaimFromJson(Map<String, dynamic> json) {
  return _Claim.fromJson(json);
}

/// @nodoc
mixin _$Claim {
  String get tipo => throw _privateConstructorUsedError;
  String get valor => throw _privateConstructorUsedError;

  /// Serializes this Claim to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClaimCopyWith<Claim> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimCopyWith<$Res> {
  factory $ClaimCopyWith(Claim value, $Res Function(Claim) then) =
      _$ClaimCopyWithImpl<$Res, Claim>;
  @useResult
  $Res call({String tipo, String valor});
}

/// @nodoc
class _$ClaimCopyWithImpl<$Res, $Val extends Claim>
    implements $ClaimCopyWith<$Res> {
  _$ClaimCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tipo = null,
    Object? valor = null,
  }) {
    return _then(_value.copyWith(
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      valor: null == valor
          ? _value.valor
          : valor // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClaimImplCopyWith<$Res> implements $ClaimCopyWith<$Res> {
  factory _$$ClaimImplCopyWith(
          _$ClaimImpl value, $Res Function(_$ClaimImpl) then) =
      __$$ClaimImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String tipo, String valor});
}

/// @nodoc
class __$$ClaimImplCopyWithImpl<$Res>
    extends _$ClaimCopyWithImpl<$Res, _$ClaimImpl>
    implements _$$ClaimImplCopyWith<$Res> {
  __$$ClaimImplCopyWithImpl(
      _$ClaimImpl _value, $Res Function(_$ClaimImpl) _then)
      : super(_value, _then);

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tipo = null,
    Object? valor = null,
  }) {
    return _then(_$ClaimImpl(
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      valor: null == valor
          ? _value.valor
          : valor // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClaimImpl implements _Claim {
  const _$ClaimImpl({required this.tipo, required this.valor});

  factory _$ClaimImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClaimImplFromJson(json);

  @override
  final String tipo;
  @override
  final String valor;

  @override
  String toString() {
    return 'Claim(tipo: $tipo, valor: $valor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimImpl &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.valor, valor) || other.valor == valor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tipo, valor);

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimImplCopyWith<_$ClaimImpl> get copyWith =>
      __$$ClaimImplCopyWithImpl<_$ClaimImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClaimImplToJson(
      this,
    );
  }
}

abstract class _Claim implements Claim {
  const factory _Claim(
      {required final String tipo, required final String valor}) = _$ClaimImpl;

  factory _Claim.fromJson(Map<String, dynamic> json) = _$ClaimImpl.fromJson;

  @override
  String get tipo;
  @override
  String get valor;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClaimImplCopyWith<_$ClaimImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
