// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'municipality.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Municipality _$MunicipalityFromJson(Map<String, dynamic> json) {
  return _Municipality.fromJson(json);
}

/// @nodoc
mixin _$Municipality {
  String get id => throw _privateConstructorUsedError;
  String get descripcion => throw _privateConstructorUsedError;
  List<Place> get lugares => throw _privateConstructorUsedError;

  /// Serializes this Municipality to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Municipality
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MunicipalityCopyWith<Municipality> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MunicipalityCopyWith<$Res> {
  factory $MunicipalityCopyWith(
          Municipality value, $Res Function(Municipality) then) =
      _$MunicipalityCopyWithImpl<$Res, Municipality>;
  @useResult
  $Res call({String id, String descripcion, List<Place> lugares});
}

/// @nodoc
class _$MunicipalityCopyWithImpl<$Res, $Val extends Municipality>
    implements $MunicipalityCopyWith<$Res> {
  _$MunicipalityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Municipality
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? descripcion = null,
    Object? lugares = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
      lugares: null == lugares
          ? _value.lugares
          : lugares // ignore: cast_nullable_to_non_nullable
              as List<Place>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MunicipalityImplCopyWith<$Res>
    implements $MunicipalityCopyWith<$Res> {
  factory _$$MunicipalityImplCopyWith(
          _$MunicipalityImpl value, $Res Function(_$MunicipalityImpl) then) =
      __$$MunicipalityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String descripcion, List<Place> lugares});
}

/// @nodoc
class __$$MunicipalityImplCopyWithImpl<$Res>
    extends _$MunicipalityCopyWithImpl<$Res, _$MunicipalityImpl>
    implements _$$MunicipalityImplCopyWith<$Res> {
  __$$MunicipalityImplCopyWithImpl(
      _$MunicipalityImpl _value, $Res Function(_$MunicipalityImpl) _then)
      : super(_value, _then);

  /// Create a copy of Municipality
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? descripcion = null,
    Object? lugares = null,
  }) {
    return _then(_$MunicipalityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
      lugares: null == lugares
          ? _value._lugares
          : lugares // ignore: cast_nullable_to_non_nullable
              as List<Place>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MunicipalityImpl extends _Municipality {
  const _$MunicipalityImpl(
      {required this.id,
      required this.descripcion,
      required final List<Place> lugares})
      : _lugares = lugares,
        super._();

  factory _$MunicipalityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MunicipalityImplFromJson(json);

  @override
  final String id;
  @override
  final String descripcion;
  final List<Place> _lugares;
  @override
  List<Place> get lugares {
    if (_lugares is EqualUnmodifiableListView) return _lugares;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lugares);
  }

  @override
  String toString() {
    return 'Municipality(id: $id, descripcion: $descripcion, lugares: $lugares)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MunicipalityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.descripcion, descripcion) ||
                other.descripcion == descripcion) &&
            const DeepCollectionEquality().equals(other._lugares, _lugares));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, descripcion,
      const DeepCollectionEquality().hash(_lugares));

  /// Create a copy of Municipality
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MunicipalityImplCopyWith<_$MunicipalityImpl> get copyWith =>
      __$$MunicipalityImplCopyWithImpl<_$MunicipalityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MunicipalityImplToJson(
      this,
    );
  }
}

abstract class _Municipality extends Municipality {
  const factory _Municipality(
      {required final String id,
      required final String descripcion,
      required final List<Place> lugares}) = _$MunicipalityImpl;
  const _Municipality._() : super._();

  factory _Municipality.fromJson(Map<String, dynamic> json) =
      _$MunicipalityImpl.fromJson;

  @override
  String get id;
  @override
  String get descripcion;
  @override
  List<Place> get lugares;

  /// Create a copy of Municipality
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MunicipalityImplCopyWith<_$MunicipalityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
