import 'package:flutter/material.dart';

import '../../constants/colors.dart';

@immutable
class DashboardThemeColors extends ThemeExtension<DashboardThemeColors> {
  final Color success;
  final Color revenue;
  final Color balance;

  const DashboardThemeColors({
    required this.success,
    required this.revenue,
    required this.balance,
  });

  static const light = DashboardThemeColors(
    success: DASHBOARD_SUCCESS,
    revenue: DASHBOARD_REVENUE,
    balance: DASHBOARD_BALANCE,
  );

  static const dark = DashboardThemeColors(
    success: VALIDATOR_ACCENT,
    revenue: DASHBOARD_REVENUE,
    balance: PRIMARY_LIGHT,
  );

  @override
  DashboardThemeColors copyWith({
    Color? success,
    Color? revenue,
    Color? balance,
  }) => DashboardThemeColors(
    success: success ?? this.success,
    revenue: revenue ?? this.revenue,
    balance: balance ?? this.balance,
  );

  @override
  DashboardThemeColors lerp(covariant DashboardThemeColors? other, double t) {
    if (other == null) {
      return this;
    }
    return DashboardThemeColors(
      success: Color.lerp(success, other.success, t) ?? success,
      revenue: Color.lerp(revenue, other.revenue, t) ?? revenue,
      balance: Color.lerp(balance, other.balance, t) ?? balance,
    );
  }
}
