import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constants/dashboard_constants.dart';
import '../../../../constants/opacities.dart';
import '../../../../constants/sizes.dart';
import '../../../../core/theme/dashboard_theme_colors.dart';
import '../../domain/entities/dashboard_snapshot.dart';
import '../formatters/dashboard_formatters.dart';

class SummaryCards extends StatelessWidget {
  final DashboardSnapshot snapshot;

  const SummaryCards({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dashboardColors =
        theme.extension<DashboardThemeColors>() ?? DashboardThemeColors.light;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= breakpointDesktop
            ? DASHBOARD_DESKTOP_COLUMN_COUNT
            : constraints.maxWidth >= breakpointMobile
            ? DASHBOARD_TABLET_COLUMN_COUNT
            : DASHBOARD_MOBILE_COLUMN_COUNT;
        final cardWidth =
            (constraints.maxWidth -
                ((columns - DASHBOARD_MOBILE_COLUMN_COUNT) * contentGap)) /
            columns;

        return Wrap(
          spacing: contentGap,
          runSpacing: contentGap,
          children: [
            _SummaryCard(
              titleKey: 'dashboard.total_users',
              value: snapshot.totalUserCount.toString(),
              icon: Icons.people,
              color: theme.colorScheme.primary,
              width: cardWidth,
            ),
            _SummaryCard(
              titleKey: 'dashboard.today_rides',
              value: snapshot.weeklyMetrics.todayRideCount.toString(),
              icon: Icons.directions_bus,
              color: dashboardColors.success,
              width: cardWidth,
            ),
            _SummaryCard(
              titleKey: 'dashboard.total_balance',
              value: formatCurrency(snapshot.totalWalletBalance),
              icon: Icons.account_balance_wallet,
              color: dashboardColors.balance,
              width: cardWidth,
            ),
            _SummaryCard(
              titleKey: 'dashboard.total_revenue',
              value: formatCurrency(snapshot.totalRevenue),
              icon: Icons.payments,
              color: dashboardColors.revenue,
              width: cardWidth,
            ),
          ],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String titleKey;
  final String value;
  final IconData icon;
  final Color color;
  final double width;

  const _SummaryCard({
    required this.titleKey,
    required this.value,
    required this.icon,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(cardPadding),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(contentGap),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: ICON_BACKGROUND),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: iconLarge),
              ),
              const SizedBox(width: cardContentGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titleKey.tr(), style: theme.textTheme.bodyMedium),
                    const SizedBox(height: compactGap),
                    Text(value, style: theme.textTheme.displayLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
