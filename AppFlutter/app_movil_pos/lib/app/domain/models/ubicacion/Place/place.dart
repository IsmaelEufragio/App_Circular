import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';
import '../colony/colony.dart';

part 'place.freezed.dart';
part 'place.g.dart';

@freezed
class Place with _$Place {
  const factory Place({
    required String id,
    required String descripcion,
    required List<Colony> colonias,
  }) = _Place;

  factory Place.fromJson(Json json) => _$PlaceFromJson(json);
  const Place._();
}
