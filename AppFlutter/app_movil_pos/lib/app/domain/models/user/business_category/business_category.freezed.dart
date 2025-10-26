// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BusinessCategory _$BusinessCategoryFromJson(Map<String, dynamic> json) {
  return _BusinessCategory.fromJson(json);
}

/// @nodoc
mixin _$BusinessCategory {
  String get id => throw _privateConstructorUsedError;
  String get descripcion => throw _privateConstructorUsedError;

  /// Serializes this BusinessCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessCategoryCopyWith<BusinessCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessCategoryCopyWith<$Res> {
  factory $BusinessCategoryCopyWith(
          BusinessCategory value, $Res Function(BusinessCategory) then) =
      _$BusinessCategoryCopyWithImpl<$Res, BusinessCategory>;
  @useResult
  $Res call({String id, String descripcion});
}

/// @nodoc
class _$BusinessCategoryCopyWithImpl<$Res, $Val extends BusinessCategory>
    implements $BusinessCategoryCopyWith<$Res> {
  _$BusinessCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? descripcion = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusinessCategoryImplCopyWith<$Res>
    implements $BusinessCategoryCopyWith<$Res> {
  factory _$$BusinessCategoryImplCopyWith(_$BusinessCategoryImpl value,
          $Res Function(_$BusinessCategoryImpl) then) =
      __$$BusinessCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String descripcion});
}

/// @nodoc
class __$$BusinessCategoryImplCopyWithImpl<$Res>
    extends _$BusinessCategoryCopyWithImpl<$Res, _$BusinessCategoryImpl>
    implements _$$BusinessCategoryImplCopyWith<$Res> {
  __$$BusinessCategoryImplCopyWithImpl(_$BusinessCategoryImpl _value,
      $Res Function(_$BusinessCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusinessCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? descripcion = null,
  }) {
    return _then(_$BusinessCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      descripcion: null == descripcion
          ? _value.descripcion
          : descripcion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessCategoryImpl implements _BusinessCategory {
  _$BusinessCategoryImpl({required this.id, required this.descripcion});

  factory _$BusinessCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessCategoryImplFromJson(json);

  @override
  final String id;
  @override
  final String descripcion;

  @override
  String toString() {
    return 'BusinessCategory(id: $id, descripcion: $descripcion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.descripcion, descripcion) ||
                other.descripcion == descripcion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, descripcion);

  /// Create a copy of BusinessCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessCategoryImplCopyWith<_$BusinessCategoryImpl> get copyWith =>
      __$$BusinessCategoryImplCopyWithImpl<_$BusinessCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessCategoryImplToJson(
      this,
    );
  }
}

abstract class _BusinessCategory implements BusinessCategory {
  factory _BusinessCategory(
      {required final String id,
      required final String descripcion}) = _$BusinessCategoryImpl;

  factory _BusinessCategory.fromJson(Map<String, dynamic> json) =
      _$BusinessCategoryImpl.fromJson;

  @override
  String get id;
  @override
  String get descripcion;

  /// Create a copy of BusinessCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessCategoryImplCopyWith<_$BusinessCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
