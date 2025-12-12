import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';

part 'colony.freezed.dart';
part 'colony.g.dart';

@freezed
class Colony with _$Colony {
  const factory Colony({
    required String id,
    required String nombre,
  }) = _Colony;

  factory Colony.fromJson(Json json) => _$ColonyFromJson(json);
  const Colony._();
}
