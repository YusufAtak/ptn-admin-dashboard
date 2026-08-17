import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.auth({
    @Default('auth.unknown_error') String messageKey,
    String? code,
  }) = _AuthFailure;

  const factory Failure.unauthorized({
    @Default('auth.unauthorized') String messageKey,
  }) = _UnauthorizedFailure;

  const factory Failure.server({
    @Default('errors.server_error') String messageKey,
    String? code,
  }) = _ServerFailure;

  const factory Failure.notFound({
    @Default('errors.not_found') String messageKey,
  }) = _NotFoundFailure;

  const factory Failure.network({
    @Default('errors.network') String messageKey,
  }) = _NetworkFailure;

  const factory Failure.unknown({
    @Default('errors.unknown') String messageKey,
  }) = _UnknownFailure;
}
