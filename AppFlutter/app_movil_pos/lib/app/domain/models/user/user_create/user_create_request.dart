// lib/app/domain/models/user/user_create/user_create_request.dart
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../business_category/business_category.dart';
import '../schedule/schedule.dart';

part 'user_create_request.freezed.dart';

@freezed
class UserCreateRequest with _$UserCreateRequest {
  const factory UserCreateRequest({
    required String idTipoUsuario,
    required String idTipoIdentidad,
    required String nombreComercial,
    required String descripcion,
    required String rtn,
    required String telefono,
    required String email,
    String? facebook,
    String? instagram,
    required bool whatsapp,
    required bool domicilio,
    required List<BusinessCategory> categorias,
    required String departamentoId,
    required String municipioId,
    required String lugarId,
    required String coloniaId,
    required double latitude,
    required double longitude,
    required List<Schedule> horarios,
    required String nombreUsuario,
    required String password,
    required File logo,
  }) = _UserCreateRequest;
}
