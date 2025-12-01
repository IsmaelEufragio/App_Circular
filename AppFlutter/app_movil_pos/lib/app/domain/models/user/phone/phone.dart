import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';

part 'phone.freezed.dart';
part 'phone.g.dart';

@freezed
class Phone with _$Phone {
  const factory Phone({
    required String telefono,
  }) = _Phone;

  factory Phone.fromJson(Json json) => _$PhoneFromJson(json);
}
