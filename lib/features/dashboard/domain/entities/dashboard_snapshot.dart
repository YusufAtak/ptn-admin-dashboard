import 'package:freezed_annotation/freezed_annotation.dart';

import 'admin_user_summary.dart';
import 'dashboard_metrics.dart';
import 'user_type_option.dart';

part 'dashboard_snapshot.freezed.dart';

@freezed
abstract class DashboardSnapshot with _$DashboardSnapshot {
  const factory DashboardSnapshot({
    required int totalUserCount,
    required double totalWalletBalance,
    required double totalRevenue,
    required DashboardWeeklyMetrics weeklyMetrics,
    @Default(<AdminUserSummary>[]) List<AdminUserSummary> users,
    @Default(<UserTypeOption>[]) List<UserTypeOption> userTypes,
  }) = _DashboardSnapshot;
}
