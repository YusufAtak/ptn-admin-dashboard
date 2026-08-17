import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_metrics.freezed.dart';

@freezed
abstract class DashboardDailyMetric with _$DashboardDailyMetric {
  const factory DashboardDailyMetric({
    required DateTime date,
    @Default(0) int rideCount,
    @Default(0.0) double revenue,
  }) = _DashboardDailyMetric;
}

@freezed
abstract class DashboardWeeklyMetrics with _$DashboardWeeklyMetrics {
  const factory DashboardWeeklyMetrics({
    @Default(0) int todayRideCount,
    @Default(<DashboardDailyMetric>[]) List<DashboardDailyMetric> days,
  }) = _DashboardWeeklyMetrics;
}
