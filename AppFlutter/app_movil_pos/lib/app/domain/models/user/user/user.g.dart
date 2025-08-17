// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      identidad: json['identidad'] as String,
      usuarioPrincipal: json['usuarioPrincipal'] as bool,
      nombreUsuario: json['nombreUsuario'] as String,
      correo: json['correo'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Rol.fromJson(e as Map<String, dynamic>))
          .toList(),
      claims: (json['claims'] as List<dynamic>)
          .map((e) => Claim.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'identidad': instance.identidad,
      'usuarioPrincipal': instance.usuarioPrincipal,
      'nombreUsuario': instance.nombreUsuario,
      'correo': instance.correo,
      'roles': instance.roles,
      'claims': instance.claims,
    };
