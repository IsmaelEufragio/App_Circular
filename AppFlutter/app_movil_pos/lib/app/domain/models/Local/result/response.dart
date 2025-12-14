import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../typedefs.dart';

part 'response.freezed.dart';
part 'response.g.dart';

@Freezed(genericArgumentFactories: true)
class Response<T> with _$Response<T> {
  const factory Response({
    required bool success,
    required T data,
    String? message,
  }) = _Response<T>;

  factory Response.fromJson(
    Json json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ResponseFromJson(json, fromJsonT);
}
