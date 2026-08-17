import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_user_summary.freezed.dart';
part 'admin_user_summary.g.dart';

@freezed
abstract class AdminUserSummary with _$AdminUserSummary {
  const factory AdminUserSummary({
    required String id,
    required String email,
    required String displayName,
    required String role,
    required String userType,
    @Default(0.0) double balance,
  }) = _AdminUserSummary;

  factory AdminUserSummary.fromJson(Map<String, dynamic> json) =>
      _$AdminUserSummaryFromJson(json);
}
