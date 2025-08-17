import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresToken.freezed.dart';
part 'refresToken.g.dart';

DateTime _fromJson(String date) => DateTime.parse(date);
String _toJson(DateTime date) => date.toUtc().toIso8601String();

@freezed
class RefresToken with _$RefresToken {
  const factory RefresToken({
    required String refresToken,
    @JsonKey(fromJson: _fromJson, toJson: _toJson) required DateTime expira,
  }) = _RefresToken;

  factory RefresToken.fromJson(Map<String, dynamic> json) =>
      _$RefresTokenFromJson(json);
}
