// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Phone _$PhoneFromJson(Map<String, dynamic> json) {
  return _Phone.fromJson(json);
}

/// @nodoc
mixin _$Phone {
  String get idTipoTelefono => throw _privateConstructorUsedError;
  String get telefono => throw _privateConstructorUsedError;

  /// Serializes this Phone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Phone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhoneCopyWith<Phone> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneCopyWith<$Res> {
  factory $PhoneCopyWith(Phone value, $Res Function(Phone) then) =
      _$PhoneCopyWithImpl<$Res, Phone>;
  @useResult
  $Res call({String idTipoTelefono, String telefono});
}

/// @nodoc
class _$PhoneCopyWithImpl<$Res, $Val extends Phone>
    implements $PhoneCopyWith<$Res> {
  _$PhoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Phone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idTipoTelefono = null,
    Object? telefono = null,
  }) {
    return _then(_value.copyWith(
      idTipoTelefono: null == idTipoTelefono
          ? _value.idTipoTelefono
          : idTipoTelefono // ignore: cast_nullable_to_non_nullable
              as String,
      telefono: null == telefono
          ? _value.telefono
          : telefono // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhoneImplCopyWith<$Res> implements $PhoneCopyWith<$Res> {
  factory _$$PhoneImplCopyWith(
          _$PhoneImpl value, $Res Function(_$PhoneImpl) then) =
      __$$PhoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String idTipoTelefono, String telefono});
}

/// @nodoc
class __$$PhoneImplCopyWithImpl<$Res>
    extends _$PhoneCopyWithImpl<$Res, _$PhoneImpl>
    implements _$$PhoneImplCopyWith<$Res> {
  __$$PhoneImplCopyWithImpl(
      _$PhoneImpl _value, $Res Function(_$PhoneImpl) _then)
      : super(_value, _then);

  /// Create a copy of Phone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idTipoTelefono = null,
    Object? telefono = null,
  }) {
    return _then(_$PhoneImpl(
      idTipoTelefono: null == idTipoTelefono
          ? _value.idTipoTelefono
          : idTipoTelefono // ignore: cast_nullable_to_non_nullable
              as String,
      telefono: null == telefono
          ? _value.telefono
          : telefono // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhoneImpl implements _Phone {
  const _$PhoneImpl({required this.idTipoTelefono, required this.telefono});

  factory _$PhoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhoneImplFromJson(json);

  @override
  final String idTipoTelefono;
  @override
  final String telefono;

  @override
  String toString() {
    return 'Phone(idTipoTelefono: $idTipoTelefono, telefono: $telefono)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneImpl &&
            (identical(other.idTipoTelefono, idTipoTelefono) ||
                other.idTipoTelefono == idTipoTelefono) &&
            (identical(other.telefono, telefono) ||
                other.telefono == telefono));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, idTipoTelefono, telefono);

  /// Create a copy of Phone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneImplCopyWith<_$PhoneImpl> get copyWith =>
      __$$PhoneImplCopyWithImpl<_$PhoneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhoneImplToJson(
      this,
    );
  }
}

abstract class _Phone implements Phone {
  const factory _Phone(
      {required final String idTipoTelefono,
      required final String telefono}) = _$PhoneImpl;

  factory _Phone.fromJson(Map<String, dynamic> json) = _$PhoneImpl.fromJson;

  @override
  String get idTipoTelefono;
  @override
  String get telefono;

  /// Create a copy of Phone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneImplCopyWith<_$PhoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
