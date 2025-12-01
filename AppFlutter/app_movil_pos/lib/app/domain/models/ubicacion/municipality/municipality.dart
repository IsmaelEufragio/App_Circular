import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';
import '../Place/place.dart';

part 'municipality.freezed.dart';
part 'municipality.g.dart';

@freezed
class Municipality with _$Municipality {
  const factory Municipality({
    required String id,
    required String descripcion,
    required List<Place> lugares,
  }) = _Municipality;

  factory Municipality.fromJson(Json json) => _$MunicipalityFromJson(json);
  const Municipality._();
}
