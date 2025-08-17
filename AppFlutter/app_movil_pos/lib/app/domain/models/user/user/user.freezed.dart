// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get identidad => throw _privateConstructorUsedError;
  bool get usuarioPrincipal => throw _privateConstructorUsedError;
  String get nombreUsuario => throw _privateConstructorUsedError;
  String get correo => throw _privateConstructorUsedError;
  List<Rol> get roles => throw _privateConstructorUsedError;
  List<Claim> get claims => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String identidad,
      bool usuarioPrincipal,
      String nombreUsuario,
      String correo,
      List<Rol> roles,
      List<Claim> claims});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identidad = null,
    Object? usuarioPrincipal = null,
    Object? nombreUsuario = null,
    Object? correo = null,
    Object? roles = null,
    Object? claims = null,
  }) {
    return _then(_value.copyWith(
      identidad: null == identidad
          ? _value.identidad
          : identidad // ignore: cast_nullable_to_non_nullable
              as String,
      usuarioPrincipal: null == usuarioPrincipal
          ? _value.usuarioPrincipal
          : usuarioPrincipal // ignore: cast_nullable_to_non_nullable
              as bool,
      nombreUsuario: null == nombreUsuario
          ? _value.nombreUsuario
          : nombreUsuario // ignore: cast_nullable_to_non_nullable
              as String,
      correo: null == correo
          ? _value.correo
          : correo // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<Rol>,
      claims: null == claims
          ? _value.claims
          : claims // ignore: cast_nullable_to_non_nullable
              as List<Claim>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String identidad,
      bool usuarioPrincipal,
      String nombreUsuario,
      String correo,
      List<Rol> roles,
      List<Claim> claims});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identidad = null,
    Object? usuarioPrincipal = null,
    Object? nombreUsuario = null,
    Object? correo = null,
    Object? roles = null,
    Object? claims = null,
  }) {
    return _then(_$UserImpl(
      identidad: null == identidad
          ? _value.identidad
          : identidad // ignore: cast_nullable_to_non_nullable
              as String,
      usuarioPrincipal: null == usuarioPrincipal
          ? _value.usuarioPrincipal
          : usuarioPrincipal // ignore: cast_nullable_to_non_nullable
              as bool,
      nombreUsuario: null == nombreUsuario
          ? _value.nombreUsuario
          : nombreUsuario // ignore: cast_nullable_to_non_nullable
              as String,
      correo: null == correo
          ? _value.correo
          : correo // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<Rol>,
      claims: null == claims
          ? _value._claims
          : claims // ignore: cast_nullable_to_non_nullable
              as List<Claim>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl(
      {required this.identidad,
      required this.usuarioPrincipal,
      required this.nombreUsuario,
      required this.correo,
      required final List<Rol> roles,
      required final List<Claim> claims})
      : _roles = roles,
        _claims = claims,
        super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String identidad;
  @override
  final bool usuarioPrincipal;
  @override
  final String nombreUsuario;
  @override
  final String correo;
  final List<Rol> _roles;
  @override
  List<Rol> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  final List<Claim> _claims;
  @override
  List<Claim> get claims {
    if (_claims is EqualUnmodifiableListView) return _claims;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_claims);
  }

  @override
  String toString() {
    return 'User(identidad: $identidad, usuarioPrincipal: $usuarioPrincipal, nombreUsuario: $nombreUsuario, correo: $correo, roles: $roles, claims: $claims)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.identidad, identidad) ||
                other.identidad == identidad) &&
            (identical(other.usuarioPrincipal, usuarioPrincipal) ||
                other.usuarioPrincipal == usuarioPrincipal) &&
            (identical(other.nombreUsuario, nombreUsuario) ||
                other.nombreUsuario == nombreUsuario) &&
            (identical(other.correo, correo) || other.correo == correo) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            const DeepCollectionEquality().equals(other._claims, _claims));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      identidad,
      usuarioPrincipal,
      nombreUsuario,
      correo,
      const DeepCollectionEquality().hash(_roles),
      const DeepCollectionEquality().hash(_claims));

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {required final String identidad,
      required final bool usuarioPrincipal,
      required final String nombreUsuario,
      required final String correo,
      required final List<Rol> roles,
      required final List<Claim> claims}) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get identidad;
  @override
  bool get usuarioPrincipal;
  @override
  String get nombreUsuario;
  @override
  String get correo;
  @override
  List<Rol> get roles;
  @override
  List<Claim> get claims;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
