// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'colony.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Colony _$ColonyFromJson(Map<String, dynamic> json) {
  return _Colony.fromJson(json);
}

/// @nodoc
mixin _$Colony {
  String get id => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;

  /// Serializes this Colony to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Colony
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ColonyCopyWith<Colony> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColonyCopyWith<$Res> {
  factory $ColonyCopyWith(Colony value, $Res Function(Colony) then) =
      _$ColonyCopyWithImpl<$Res, Colony>;
  @useResult
  $Res call({String id, String nombre});
}

/// @nodoc
class _$ColonyCopyWithImpl<$Res, $Val extends Colony>
    implements $ColonyCopyWith<$Res> {
  _$ColonyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Colony
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ColonyImplCopyWith<$Res> implements $ColonyCopyWith<$Res> {
  factory _$$ColonyImplCopyWith(
          _$ColonyImpl value, $Res Function(_$ColonyImpl) then) =
      __$$ColonyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String nombre});
}

/// @nodoc
class __$$ColonyImplCopyWithImpl<$Res>
    extends _$ColonyCopyWithImpl<$Res, _$ColonyImpl>
    implements _$$ColonyImplCopyWith<$Res> {
  __$$ColonyImplCopyWithImpl(
      _$ColonyImpl _value, $Res Function(_$ColonyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Colony
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
  }) {
    return _then(_$ColonyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColonyImpl extends _Colony {
  const _$ColonyImpl({required this.id, required this.nombre}) : super._();

  factory _$ColonyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColonyImplFromJson(json);

  @override
  final String id;
  @override
  final String nombre;

  @override
  String toString() {
    return 'Colony(id: $id, nombre: $nombre)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColonyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nombre, nombre) || other.nombre == nombre));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nombre);

  /// Create a copy of Colony
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ColonyImplCopyWith<_$ColonyImpl> get copyWith =>
      __$$ColonyImplCopyWithImpl<_$ColonyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColonyImplToJson(
      this,
    );
  }
}

abstract class _Colony extends Colony {
  const factory _Colony(
      {required final String id, required final String nombre}) = _$ColonyImpl;
  const _Colony._() : super._();

  factory _Colony.fromJson(Map<String, dynamic> json) = _$ColonyImpl.fromJson;

  @override
  String get id;
  @override
  String get nombre;

  /// Create a copy of Colony
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ColonyImplCopyWith<_$ColonyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
