import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim.freezed.dart';
part 'claim.g.dart';

@freezed
class Claim with _$Claim {
  const factory Claim({
    required String tipo,
    required String valor,
  }) = _Claim;

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);
}
