import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';

part 'place.freezed.dart';
part 'place.g.dart';

@freezed
class Place with _$Place {
  const factory Place({required String id, required String descripcion}) =
      _Place;

  factory Place.fromJson(Json json) => _$PlaceFromJson(json);
  const Place._();
}
