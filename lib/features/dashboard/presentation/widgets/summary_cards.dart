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
        final isDesktop = constraints.maxWidth >= breakpointDesktop;
        final isTablet = constraints.maxWidth >= breakpointMobile;

        final columns = isDesktop
            ? DASHBOARD_DESKTOP_COLUMN_COUNT
            : isTablet
                ? DASHBOARD_TABLET_COLUMN_COUNT
                : DASHBOARD_MOBILE_COLUMN_COUNT;

        final gap = isTablet ? contentGap : mediumGap;
        final cardWidth =
            (constraints.maxWidth - ((columns - 1) * gap)) / columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            _SummaryCard(
              titleKey: 'dashboard.total_users',
              value: snapshot.totalUserCount.toString(),
              icon: Icons.people,
              color: theme.colorScheme.primary,
              width: cardWidth,
              isMobile: !isTablet,
            ),
            _SummaryCard(
              titleKey: 'dashboard.today_rides',
              value: snapshot.weeklyMetrics.todayRideCount.toString(),
              icon: Icons.directions_bus,
              color: dashboardColors.success,
              width: cardWidth,
              isMobile: !isTablet,
            ),
            _SummaryCard(
              titleKey: 'dashboard.total_balance',
              value: formatCurrency(snapshot.totalWalletBalance),
              icon: Icons.account_balance_wallet,
              color: dashboardColors.balance,
              width: cardWidth,
              isMobile: !isTablet,
            ),
            _SummaryCard(
              titleKey: 'dashboard.total_revenue',
              value: formatCurrency(snapshot.totalRevenue),
              icon: Icons.payments,
              color: dashboardColors.revenue,
              width: cardWidth,
              isMobile: !isTablet,
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
  final bool isMobile;

  const _SummaryCard({
    required this.titleKey,
    required this.value,
    required this.icon,
    required this.color,
    required this.width,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = isMobile ? cardPaddingMobile : cardPadding;

    return SizedBox(
      width: width,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      titleKey.tr(),
                      style: theme.textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: smallGap),
                    Text(
                      value,
                      style: isMobile
                          ? theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            )
                          : theme.textTheme.displayLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
