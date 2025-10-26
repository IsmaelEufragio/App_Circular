// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_crear_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserCrearState {
  String get nombre => throw _privateConstructorUsedError;
  String get descripcion => throw _privateConstructorUsedError;
  String get rtn => throw _privateConstructorUsedError;
  String get rtnPersonal => throw _privateConstructorUsedError;
  int get IdRubro => throw _privateConstructorUsedError;

  /// Create a copy of UserCrearState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCrearStateCopyWith<UserCrearState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCrearStateCopyWith<$Res> {
  factory $UserCrearStateCopyWith(
          UserCrearState value, $Res Function(UserCrearState) then) =
      _$UserCrearStateCopyWithImpl<$Res, UserCrearState>;
  @useResult
  $Res call(
      {String nombre,
      String descripcion,
      String rtn,
      String rtnPersonal,
      int IdRubro});
}

/// @nodoc
class _$UserCrearStateCopyWithImpl<$Res, $Val extends UserCrearState>
    implements $UserCrearStateCopyWith<$Res> {
  _$UserCrearStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserCrearState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = null,
    Object? descripcion = null,
    Object? rtn = null,
    Object? rtnPersonal = null,
    Object? IdRubro = null,
  }) {
    return _then(_value.copyWith(
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
      rtn: null == rtn
          ? _value.rtn
          : rtn // ignore: cast_nullable_to_non_nullable
              as String,
      rtnPersonal: null == rtnPersonal
          ? _value.rtnPersonal
          : rtnPersonal // ignore: cast_nullable_to_non_nullable
              as String,
      IdRubro: null == IdRubro
          ? _value.IdRubro
          : IdRubro // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserCrearStateImplCopyWith<$Res>
    implements $UserCrearStateCopyWith<$Res> {
  factory _$$UserCrearStateImplCopyWith(_$UserCrearStateImpl value,
          $Res Function(_$UserCrearStateImpl) then) =
      __$$UserCrearStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nombre,
      String descripcion,
      String rtn,
      String rtnPersonal,
      int IdRubro});
}

/// @nodoc
class __$$UserCrearStateImplCopyWithImpl<$Res>
    extends _$UserCrearStateCopyWithImpl<$Res, _$UserCrearStateImpl>
    implements _$$UserCrearStateImplCopyWith<$Res> {
  __$$UserCrearStateImplCopyWithImpl(
      _$UserCrearStateImpl _value, $Res Function(_$UserCrearStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserCrearState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = null,
    Object? descripcion = null,
    Object? rtn = null,
    Object? rtnPersonal = null,
    Object? IdRubro = null,
  }) {
    return _then(_$UserCrearStateImpl(
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
      rtn: null == rtn
          ? _value.rtn
          : rtn // ignore: cast_nullable_to_non_nullable
              as String,
      rtnPersonal: null == rtnPersonal
          ? _value.rtnPersonal
          : rtnPersonal // ignore: cast_nullable_to_non_nullable
              as String,
      IdRubro: null == IdRubro
          ? _value.IdRubro
          : IdRubro // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UserCrearStateImpl implements _UserCrearState {
  _$UserCrearStateImpl(
      {this.nombre = '',
      this.descripcion = '',
      this.rtn = '',
      this.rtnPersonal = '',
      this.IdRubro = 0});

  @override
  @JsonKey()
  final String nombre;
  @override
  @JsonKey()
  final String descripcion;
  @override
  @JsonKey()
  final String rtn;
  @override
  @JsonKey()
  final String rtnPersonal;
  @override
  @JsonKey()
  final int IdRubro;

  @override
  String toString() {
    return 'UserCrearState(nombre: $nombre, descripcion: $descripcion, rtn: $rtn, rtnPersonal: $rtnPersonal, IdRubro: $IdRubro)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCrearStateImpl &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.descripcion, descripcion) ||
                other.descripcion == descripcion) &&
            (identical(other.rtn, rtn) || other.rtn == rtn) &&
            (identical(other.rtnPersonal, rtnPersonal) ||
                other.rtnPersonal == rtnPersonal) &&
            (identical(other.IdRubro, IdRubro) || other.IdRubro == IdRubro));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, nombre, descripcion, rtn, rtnPersonal, IdRubro);

  /// Create a copy of UserCrearState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCrearStateImplCopyWith<_$UserCrearStateImpl> get copyWith =>
      __$$UserCrearStateImplCopyWithImpl<_$UserCrearStateImpl>(
          this, _$identity);
}

abstract class _UserCrearState implements UserCrearState {
  factory _UserCrearState(
      {final String nombre,
      final String descripcion,
      final String rtn,
      final String rtnPersonal,
      final int IdRubro}) = _$UserCrearStateImpl;

  @override
  String get nombre;
  @override
  String get descripcion;
  @override
  String get rtn;
  @override
  String get rtnPersonal;
  @override
  int get IdRubro;

  /// Create a copy of UserCrearState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserCrearStateImplCopyWith<_$UserCrearStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
