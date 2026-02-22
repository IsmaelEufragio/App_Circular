// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleImpl _$$ScheduleImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleImpl(
      diaNumero: (json['diaNumero'] as num).toInt(),
      horaInicio: json['horaInicio'] as String,
      horaFin: json['horaFin'] as String,
    );

Map<String, dynamic> _$$ScheduleImplToJson(_$ScheduleImpl instance) =>
    <String, dynamic>{
      'diaNumero': instance.diaNumero,
      'horaInicio': instance.horaInicio,
      'horaFin': instance.horaFin,
    };
