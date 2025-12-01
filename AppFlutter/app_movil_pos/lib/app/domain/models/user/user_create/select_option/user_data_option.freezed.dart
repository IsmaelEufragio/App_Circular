// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserDataOption _$UserDataOptionFromJson(Map<String, dynamic> json) {
  return _UserDataOption.fromJson(json);
}

/// @nodoc
mixin _$UserDataOption {
  List<Department> get departamentos => throw _privateConstructorUsedError;
  List<BusinessCategory> get categoriaNegocios =>
      throw _privateConstructorUsedError;

  /// Serializes this UserDataOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserDataOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserDataOptionCopyWith<UserDataOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataOptionCopyWith<$Res> {
  factory $UserDataOptionCopyWith(
          UserDataOption value, $Res Function(UserDataOption) then) =
      _$UserDataOptionCopyWithImpl<$Res, UserDataOption>;
  @useResult
  $Res call(
      {List<Department> departamentos,
      List<BusinessCategory> categoriaNegocios});
}

/// @nodoc
class _$UserDataOptionCopyWithImpl<$Res, $Val extends UserDataOption>
    implements $UserDataOptionCopyWith<$Res> {
  _$UserDataOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserDataOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departamentos = null,
    Object? categoriaNegocios = null,
  }) {
    return _then(_value.copyWith(
      departamentos: null == departamentos
          ? _value.departamentos
          : departamentos // ignore: cast_nullable_to_non_nullable
              as List<Department>,
      categoriaNegocios: null == categoriaNegocios
          ? _value.categoriaNegocios
          : categoriaNegocios // ignore: cast_nullable_to_non_nullable
              as List<BusinessCategory>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataOptionImplCopyWith<$Res>
    implements $UserDataOptionCopyWith<$Res> {
  factory _$$UserDataOptionImplCopyWith(_$UserDataOptionImpl value,
          $Res Function(_$UserDataOptionImpl) then) =
      __$$UserDataOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Department> departamentos,
      List<BusinessCategory> categoriaNegocios});
}

/// @nodoc
class __$$UserDataOptionImplCopyWithImpl<$Res>
    extends _$UserDataOptionCopyWithImpl<$Res, _$UserDataOptionImpl>
    implements _$$UserDataOptionImplCopyWith<$Res> {
  __$$UserDataOptionImplCopyWithImpl(
      _$UserDataOptionImpl _value, $Res Function(_$UserDataOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserDataOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? departamentos = null,
    Object? categoriaNegocios = null,
  }) {
    return _then(_$UserDataOptionImpl(
      departamentos: null == departamentos
          ? _value._departamentos
          : departamentos // ignore: cast_nullable_to_non_nullable
              as List<Department>,
      categoriaNegocios: null == categoriaNegocios
          ? _value._categoriaNegocios
          : categoriaNegocios // ignore: cast_nullable_to_non_nullable
              as List<BusinessCategory>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataOptionImpl extends _UserDataOption {
  const _$UserDataOptionImpl(
      {required final List<Department> departamentos,
      required final List<BusinessCategory> categoriaNegocios})
      : _departamentos = departamentos,
        _categoriaNegocios = categoriaNegocios,
        super._();

  factory _$UserDataOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataOptionImplFromJson(json);

  final List<Department> _departamentos;
  @override
  List<Department> get departamentos {
    if (_departamentos is EqualUnmodifiableListView) return _departamentos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_departamentos);
  }

  final List<BusinessCategory> _categoriaNegocios;
  @override
  List<BusinessCategory> get categoriaNegocios {
    if (_categoriaNegocios is EqualUnmodifiableListView)
      return _categoriaNegocios;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoriaNegocios);
  }

  @override
  String toString() {
    return 'UserDataOption(departamentos: $departamentos, categoriaNegocios: $categoriaNegocios)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataOptionImpl &&
            const DeepCollectionEquality()
                .equals(other._departamentos, _departamentos) &&
            const DeepCollectionEquality()
                .equals(other._categoriaNegocios, _categoriaNegocios));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_departamentos),
      const DeepCollectionEquality().hash(_categoriaNegocios));

  /// Create a copy of UserDataOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataOptionImplCopyWith<_$UserDataOptionImpl> get copyWith =>
      __$$UserDataOptionImplCopyWithImpl<_$UserDataOptionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataOptionImplToJson(
      this,
    );
  }
}

abstract class _UserDataOption extends UserDataOption {
  const factory _UserDataOption(
          {required final List<Department> departamentos,
          required final List<BusinessCategory> categoriaNegocios}) =
      _$UserDataOptionImpl;
  const _UserDataOption._() : super._();

  factory _UserDataOption.fromJson(Map<String, dynamic> json) =
      _$UserDataOptionImpl.fromJson;

  @override
  List<Department> get departamentos;
  @override
  List<BusinessCategory> get categoriaNegocios;

  /// Create a copy of UserDataOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserDataOptionImplCopyWith<_$UserDataOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
