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
  String get id => throw _privateConstructorUsedError;
  String get despcripcion => throw _privateConstructorUsedError;
  String get identidad => throw _privateConstructorUsedError;
  bool get usuarioPrincipal => throw _privateConstructorUsedError;
  String get correo => throw _privateConstructorUsedError;
  String get fecebook => throw _privateConstructorUsedError;
  List<Rol> get roles => throw _privateConstructorUsedError;
  List<Claim> get claims => throw _privateConstructorUsedError;
  List<Phone> get telefonos => throw _privateConstructorUsedError;
  @JsonKey(name: 'nombreUsuario')
  String get nombre => throw _privateConstructorUsedError;
  @JsonKey(name: 'idUserPrincipal')
  String get idPrincipal => throw _privateConstructorUsedError;
  @JsonKey(readValue: readLogoValue)
  String get rutaDelLogo => throw _privateConstructorUsedError;
  @JsonKey(readValue: readNombreValue)
  String get nombreComercial => throw _privateConstructorUsedError;

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
      {String id,
      String despcripcion,
      String identidad,
      bool usuarioPrincipal,
      String correo,
      String fecebook,
      List<Rol> roles,
      List<Claim> claims,
      List<Phone> telefonos,
      @JsonKey(name: 'nombreUsuario') String nombre,
      @JsonKey(name: 'idUserPrincipal') String idPrincipal,
      @JsonKey(readValue: readLogoValue) String rutaDelLogo,
      @JsonKey(readValue: readNombreValue) String nombreComercial});
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
    Object? id = null,
    Object? despcripcion = null,
    Object? identidad = null,
    Object? usuarioPrincipal = null,
    Object? correo = null,
    Object? fecebook = null,
    Object? roles = null,
    Object? claims = null,
    Object? telefonos = null,
    Object? nombre = null,
    Object? idPrincipal = null,
    Object? rutaDelLogo = null,
    Object? nombreComercial = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      despcripcion: null == despcripcion
          ? _value.despcripcion
          : despcripcion // ignore: cast_nullable_to_non_nullable
              as String,
      identidad: null == identidad
          ? _value.identidad
          : identidad // ignore: cast_nullable_to_non_nullable
              as String,
      usuarioPrincipal: null == usuarioPrincipal
          ? _value.usuarioPrincipal
          : usuarioPrincipal // ignore: cast_nullable_to_non_nullable
              as bool,
      correo: null == correo
          ? _value.correo
          : correo // ignore: cast_nullable_to_non_nullable
              as String,
      fecebook: null == fecebook
          ? _value.fecebook
          : fecebook // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<Rol>,
      claims: null == claims
          ? _value.claims
          : claims // ignore: cast_nullable_to_non_nullable
              as List<Claim>,
      telefonos: null == telefonos
          ? _value.telefonos
          : telefonos // ignore: cast_nullable_to_non_nullable
              as List<Phone>,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      idPrincipal: null == idPrincipal
          ? _value.idPrincipal
          : idPrincipal // ignore: cast_nullable_to_non_nullable
              as String,
      rutaDelLogo: null == rutaDelLogo
          ? _value.rutaDelLogo
          : rutaDelLogo // ignore: cast_nullable_to_non_nullable
              as String,
      nombreComercial: null == nombreComercial
          ? _value.nombreComercial
          : nombreComercial // ignore: cast_nullable_to_non_nullable
              as String,
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
      {String id,
      String despcripcion,
      String identidad,
      bool usuarioPrincipal,
      String correo,
      String fecebook,
      List<Rol> roles,
      List<Claim> claims,
      List<Phone> telefonos,
      @JsonKey(name: 'nombreUsuario') String nombre,
      @JsonKey(name: 'idUserPrincipal') String idPrincipal,
      @JsonKey(readValue: readLogoValue) String rutaDelLogo,
      @JsonKey(readValue: readNombreValue) String nombreComercial});
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
    Object? id = null,
    Object? despcripcion = null,
    Object? identidad = null,
    Object? usuarioPrincipal = null,
    Object? correo = null,
    Object? fecebook = null,
    Object? roles = null,
    Object? claims = null,
    Object? telefonos = null,
    Object? nombre = null,
    Object? idPrincipal = null,
    Object? rutaDelLogo = null,
    Object? nombreComercial = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      despcripcion: null == despcripcion
          ? _value.despcripcion
          : despcripcion // ignore: cast_nullable_to_non_nullable
              as String,
      identidad: null == identidad
          ? _value.identidad
          : identidad // ignore: cast_nullable_to_non_nullable
              as String,
      usuarioPrincipal: null == usuarioPrincipal
          ? _value.usuarioPrincipal
          : usuarioPrincipal // ignore: cast_nullable_to_non_nullable
              as bool,
      correo: null == correo
          ? _value.correo
          : correo // ignore: cast_nullable_to_non_nullable
              as String,
      fecebook: null == fecebook
          ? _value.fecebook
          : fecebook // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<Rol>,
      claims: null == claims
          ? _value._claims
          : claims // ignore: cast_nullable_to_non_nullable
              as List<Claim>,
      telefonos: null == telefonos
          ? _value._telefonos
          : telefonos // ignore: cast_nullable_to_non_nullable
              as List<Phone>,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      idPrincipal: null == idPrincipal
          ? _value.idPrincipal
          : idPrincipal // ignore: cast_nullable_to_non_nullable
              as String,
      rutaDelLogo: null == rutaDelLogo
          ? _value.rutaDelLogo
          : rutaDelLogo // ignore: cast_nullable_to_non_nullable
              as String,
      nombreComercial: null == nombreComercial
          ? _value.nombreComercial
          : nombreComercial // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl(
      {required this.id,
      required this.despcripcion,
      required this.identidad,
      required this.usuarioPrincipal,
      required this.correo,
      required this.fecebook,
      final List<Rol> roles = const [],
      required final List<Claim> claims,
      required final List<Phone> telefonos,
      @JsonKey(name: 'nombreUsuario') required this.nombre,
      @JsonKey(name: 'idUserPrincipal') required this.idPrincipal,
      @JsonKey(readValue: readLogoValue) required this.rutaDelLogo,
      @JsonKey(readValue: readNombreValue) required this.nombreComercial})
      : _roles = roles,
        _claims = claims,
        _telefonos = telefonos,
        super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String despcripcion;
  @override
  final String identidad;
  @override
  final bool usuarioPrincipal;
  @override
  final String correo;
  @override
  final String fecebook;
  final List<Rol> _roles;
  @override
  @JsonKey()
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

  final List<Phone> _telefonos;
  @override
  List<Phone> get telefonos {
    if (_telefonos is EqualUnmodifiableListView) return _telefonos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_telefonos);
  }

  @override
  @JsonKey(name: 'nombreUsuario')
  final String nombre;
  @override
  @JsonKey(name: 'idUserPrincipal')
  final String idPrincipal;
  @override
  @JsonKey(readValue: readLogoValue)
  final String rutaDelLogo;
  @override
  @JsonKey(readValue: readNombreValue)
  final String nombreComercial;

  @override
  String toString() {
    return 'User(id: $id, despcripcion: $despcripcion, identidad: $identidad, usuarioPrincipal: $usuarioPrincipal, correo: $correo, fecebook: $fecebook, roles: $roles, claims: $claims, telefonos: $telefonos, nombre: $nombre, idPrincipal: $idPrincipal, rutaDelLogo: $rutaDelLogo, nombreComercial: $nombreComercial)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.despcripcion, despcripcion) ||
                other.despcripcion == despcripcion) &&
            (identical(other.identidad, identidad) ||
                other.identidad == identidad) &&
            (identical(other.usuarioPrincipal, usuarioPrincipal) ||
                other.usuarioPrincipal == usuarioPrincipal) &&
            (identical(other.correo, correo) || other.correo == correo) &&
            (identical(other.fecebook, fecebook) ||
                other.fecebook == fecebook) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            const DeepCollectionEquality().equals(other._claims, _claims) &&
            const DeepCollectionEquality()
                .equals(other._telefonos, _telefonos) &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.idPrincipal, idPrincipal) ||
                other.idPrincipal == idPrincipal) &&
            (identical(other.rutaDelLogo, rutaDelLogo) ||
                other.rutaDelLogo == rutaDelLogo) &&
            (identical(other.nombreComercial, nombreComercial) ||
                other.nombreComercial == nombreComercial));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      despcripcion,
      identidad,
      usuarioPrincipal,
      correo,
      fecebook,
      const DeepCollectionEquality().hash(_roles),
      const DeepCollectionEquality().hash(_claims),
      const DeepCollectionEquality().hash(_telefonos),
      nombre,
      idPrincipal,
      rutaDelLogo,
      nombreComercial);

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
      {required final String id,
      required final String despcripcion,
      required final String identidad,
      required final bool usuarioPrincipal,
      required final String correo,
      required final String fecebook,
      final List<Rol> roles,
      required final List<Claim> claims,
      required final List<Phone> telefonos,
      @JsonKey(name: 'nombreUsuario') required final String nombre,
      @JsonKey(name: 'idUserPrincipal') required final String idPrincipal,
      @JsonKey(readValue: readLogoValue) required final String rutaDelLogo,
      @JsonKey(readValue: readNombreValue)
      required final String nombreComercial}) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get despcripcion;
  @override
  String get identidad;
  @override
  bool get usuarioPrincipal;
  @override
  String get correo;
  @override
  String get fecebook;
  @override
  List<Rol> get roles;
  @override
  List<Claim> get claims;
  @override
  List<Phone> get telefonos;
  @override
  @JsonKey(name: 'nombreUsuario')
  String get nombre;
  @override
  @JsonKey(name: 'idUserPrincipal')
  String get idPrincipal;
  @override
  @JsonKey(readValue: readLogoValue)
  String get rutaDelLogo;
  @override
  @JsonKey(readValue: readNombreValue)
  String get nombreComercial;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
