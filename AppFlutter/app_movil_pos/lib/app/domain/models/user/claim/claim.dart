import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';

part 'claim.freezed.dart';
part 'claim.g.dart';

@freezed
class Claim with _$Claim {
  const factory Claim({
    required String tipo,
    required String valor,
  }) = _Claim;

  factory Claim.fromJson(Json json) => _$ClaimFromJson(json);
}
