import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  const factory Schedule({
    required int diaNumero,
    required String horaInicio,
    required String horaFin,
  }) = _Schedule;
  factory Schedule.fromJson(Json json) => _$ScheduleFromJson(json);
}
