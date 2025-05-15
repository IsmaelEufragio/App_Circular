import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_failure.freezed.dart';

@freezed
class SignInFailure with _$SignInFailure {
  const factory SignInFailure.notFound() = _NotFound;
  const factory SignInFailure.notVerified() = _NotVerified;
  const factory SignInFailure.network() = _Network;
  const factory SignInFailure.unauthorized() = _Unauthorized;
  const factory SignInFailure.unknown() = _Unknown;
}
