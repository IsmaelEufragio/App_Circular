// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Rol _$RolFromJson(Map<String, dynamic> json) {
  return _Rol.fromJson(json);
}

/// @nodoc
mixin _$Rol {
  String get nombre => throw _privateConstructorUsedError;
  String get nombreNormalizado => throw _privateConstructorUsedError;

  /// Serializes this Rol to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Rol
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RolCopyWith<Rol> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RolCopyWith<$Res> {
  factory $RolCopyWith(Rol value, $Res Function(Rol) then) =
      _$RolCopyWithImpl<$Res, Rol>;
  @useResult
  $Res call({String nombre, String nombreNormalizado});
}

/// @nodoc
class _$RolCopyWithImpl<$Res, $Val extends Rol> implements $RolCopyWith<$Res> {
  _$RolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Rol
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = null,
    Object? nombreNormalizado = null,
  }) {
    return _then(_value.copyWith(
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      nombreNormalizado: null == nombreNormalizado
          ? _value.nombreNormalizado
          : nombreNormalizado // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RolImplCopyWith<$Res> implements $RolCopyWith<$Res> {
  factory _$$RolImplCopyWith(_$RolImpl value, $Res Function(_$RolImpl) then) =
      __$$RolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nombre, String nombreNormalizado});
}

/// @nodoc
class __$$RolImplCopyWithImpl<$Res> extends _$RolCopyWithImpl<$Res, _$RolImpl>
    implements _$$RolImplCopyWith<$Res> {
  __$$RolImplCopyWithImpl(_$RolImpl _value, $Res Function(_$RolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Rol
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = null,
    Object? nombreNormalizado = null,
  }) {
    return _then(_$RolImpl(
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      nombreNormalizado: null == nombreNormalizado
          ? _value.nombreNormalizado
          : nombreNormalizado // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RolImpl implements _Rol {
  const _$RolImpl({required this.nombre, required this.nombreNormalizado});

  factory _$RolImpl.fromJson(Map<String, dynamic> json) =>
      _$$RolImplFromJson(json);

  @override
  final String nombre;
  @override
  final String nombreNormalizado;

  @override
  String toString() {
    return 'Rol(nombre: $nombre, nombreNormalizado: $nombreNormalizado)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RolImpl &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.nombreNormalizado, nombreNormalizado) ||
                other.nombreNormalizado == nombreNormalizado));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nombre, nombreNormalizado);

  /// Create a copy of Rol
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RolImplCopyWith<_$RolImpl> get copyWith =>
      __$$RolImplCopyWithImpl<_$RolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RolImplToJson(
      this,
    );
  }
}

abstract class _Rol implements Rol {
  const factory _Rol(
      {required final String nombre,
      required final String nombreNormalizado}) = _$RolImpl;

  factory _Rol.fromJson(Map<String, dynamic> json) = _$RolImpl.fromJson;

  @override
  String get nombre;
  @override
  String get nombreNormalizado;

  /// Create a copy of Rol
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RolImplCopyWith<_$RolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
