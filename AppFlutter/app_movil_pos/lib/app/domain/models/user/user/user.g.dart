// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      despcripcion: json['despcripcion'] as String,
      identidad: json['identidad'] as String,
      usuarioPrincipal: json['usuarioPrincipal'] as bool,
      correo: json['correo'] as String,
      fecebook: json['fecebook'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Rol.fromJson(e as Map<String, dynamic>))
          .toList(),
      claims: (json['claims'] as List<dynamic>)
          .map((e) => Claim.fromJson(e as Map<String, dynamic>))
          .toList(),
      telefonos: (json['telefonos'] as List<dynamic>)
          .map((e) => Phone.fromJson(e as Map<String, dynamic>))
          .toList(),
      nombre: json['nombreUsuario'] as String,
      idPrincipal: json['idUserPrincipal'] as String,
      rutaDelLogo: readLogoValue(json, 'rutaDelLogo') as String,
      nombreComercial: readNombreValue(json, 'nombreComercial') as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'despcripcion': instance.despcripcion,
      'identidad': instance.identidad,
      'usuarioPrincipal': instance.usuarioPrincipal,
      'correo': instance.correo,
      'fecebook': instance.fecebook,
      'roles': instance.roles,
      'claims': instance.claims,
      'telefonos': instance.telefonos,
      'nombreUsuario': instance.nombre,
      'idUserPrincipal': instance.idPrincipal,
      'rutaDelLogo': instance.rutaDelLogo,
      'nombreComercial': instance.nombreComercial,
    };
