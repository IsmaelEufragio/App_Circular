import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';

part 'geolocator.freezed.dart';
part 'geolocator.g.dart';

@freezed
class Geolocator with _$Geolocator {
  const factory Geolocator({
    required double latitude,
    required double longitude,
    required double accuracy,
    required String formatted,
  }) = _Geolocator;

  factory Geolocator.fromJson(Json json) => _$GeolocatorFromJson(json);
}
