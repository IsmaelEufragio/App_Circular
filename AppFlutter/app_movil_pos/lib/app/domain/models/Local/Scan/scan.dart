import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';

part 'scan.freezed.dart';
part 'scan.g.dart';

@freezed
class Scan with _$Scan {
  const factory Scan({
    required String qscCode,
  }) = _Scan;
  factory Scan.fromJson(Json json) => _$ScanFromJson(json);
}
