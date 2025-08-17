import 'package:freezed_annotation/freezed_annotation.dart';

part 'accessToken.freezed.dart';
part 'accessToken.g.dart';

DateTime _fromJson(String date) => DateTime.parse(date);
String _toJson(DateTime date) => date.toUtc().toIso8601String();

@freezed
class AccessToken with _$AccessToken {
  const factory AccessToken({
    required String tokenAccess,
    @JsonKey(fromJson: _fromJson, toJson: _toJson) required DateTime expira,
  }) = _AccessToken;

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);
}
