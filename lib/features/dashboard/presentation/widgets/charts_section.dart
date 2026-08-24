import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../constants/dashboard_constants.dart';
import '../../../../constants/opacities.dart';
import '../../../../constants/sizes.dart';
import '../../../../core/theme/dashboard_theme_colors.dart';
import '../../domain/entities/dashboard_metrics.dart';
import '../formatters/dashboard_formatters.dart';

class ChartsSection extends StatelessWidget {
  final List<DashboardDailyMetric> days;

  const ChartsSection({required this.days, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= breakpointChartWide;
        final isMobile = constraints.maxWidth < breakpointMobile;
        final chartWidth = isWide
            ? (constraints.maxWidth - contentGap) /
                  DASHBOARD_TABLET_COLUMN_COUNT
            : constraints.maxWidth;

        return Wrap(
          spacing: contentGap,
          runSpacing: contentGap,
          children: [
            _ChartCard(
              width: chartWidth,
              titleKey: 'dashboard.daily_rides',
              subtitleKey: 'dashboard.successful_rides',
              isCompact: isMobile,
              child: _RideBarChart(days: days),
            ),
            _ChartCard(
              width: chartWidth,
              titleKey: 'dashboard.daily_revenue',
              subtitleKey: 'dashboard.wallet_rides',
              isCompact: isMobile,
              child: _RevenueLineChart(days: days),
            ),
          ],
        );
      },
    );
  }
}

class _ChartCard extends StatelessWidget {
  final double width;
  final String titleKey;
  final String subtitleKey;
  final Widget child;
  final bool isCompact;

  const _ChartCard({
    required this.width,
    required this.titleKey,
    required this.subtitleKey,
    required this.child,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = isCompact ? cardPaddingMobile : chartCardPadding;
    final h = isCompact ? chartHeightMobile : chartHeight;

    return SizedBox(
      width: width,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titleKey.tr(), style: theme.textTheme.headlineLarge),
              const SizedBox(height: smallGap),
              Text(subtitleKey.tr(), style: theme.textTheme.labelMedium),
              const SizedBox(height: mediumGap),
              SizedBox(height: h, child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class _RideBarChart extends StatelessWidget {
  final List<DashboardDailyMetric> days;

  const _RideBarChart({required this.days});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dashboardColors =
        theme.extension<DashboardThemeColors>() ?? DashboardThemeColors.light;

    final barWidth = switch (days.length) {
      <= 7 => chartBarWidth,
      <= 14 => chartBarWidthMedium,
      _ => chartBarWidthSmall,
    };

    final maxRide = days.fold<int>(
      0,
      (prev, d) => d.rideCount > prev ? d.rideCount : prev,
    );
    final (maxY, interval) = _calculateNiceAxis(maxRide.toDouble());

    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maxY,
        alignment: BarChartAlignment.spaceAround,
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) =>
                theme.colorScheme.surfaceContainerHighest,
            tooltipBorder: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: HALF),
              width: 1,
            ),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.toInt().toString(),
                theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ) ??
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
              );
            },
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: interval,
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.colorScheme.onSurface.withValues(alpha: SHADOW),
            strokeWidth: 1,
          ),
        ),
        titlesData: _chartTitles(days, theme, interval: interval, maxY: maxY),
        barGroups: [
          for (var index = 0; index < days.length; index++)
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: days[index].rideCount.toDouble(),
                  width: barWidth,
                  color: dashboardColors.success,
                  borderRadius: BorderRadius.circular(smallGap),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _RevenueLineChart extends StatelessWidget {
  final List<DashboardDailyMetric> days;

  const _RevenueLineChart({required this.days});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dashboardColors =
        theme.extension<DashboardThemeColors>() ?? DashboardThemeColors.light;

    final maxRevenue = days.fold<double>(
      0,
      (prev, d) => d.revenue > prev ? d.revenue : prev,
    );
    final (maxY, interval) = _calculateNiceAxis(maxRevenue);

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY,
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) =>
                theme.colorScheme.surfaceContainerHighest,
            tooltipBorder: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: HALF),
              width: 1,
            ),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  formatCurrency(spot.y),
                  theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ) ??
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                );
              }).toList();
            },
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: interval,
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.colorScheme.onSurface.withValues(alpha: SHADOW),
            strokeWidth: 1,
          ),
        ),
        titlesData: _chartTitles(days, theme, interval: interval, maxY: maxY),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var index = 0; index < days.length; index++)
                FlSpot(index.toDouble(), days[index].revenue),
            ],
            isCurved: true,
            preventCurveOverShooting: true,
            barWidth: chartLineWidth,
            color: dashboardColors.revenue,
            dotData: FlDotData(show: days.length <= 14),
            belowBarData: BarAreaData(
              show: true,
              color: dashboardColors.revenue.withValues(alpha: CHART_AREA),
            ),
          ),
        ],
      ),
    );
  }
}

(double maxY, double interval) _calculateNiceAxis(double maxValue) {
  if (maxValue <= 0) return (5.0, 1.0);
  if (maxValue <= 5) return (5.0, 1.0);
  if (maxValue <= 10) return (10.0, 2.0);
  if (maxValue <= 20) return (20.0, 5.0);
  if (maxValue <= 30) return (35.0, 5.0);
  if (maxValue <= 50) return (50.0, 10.0);
  if (maxValue <= 100) return (((maxValue / 20).ceil() * 20.0) + 10.0, 20.0);
  if (maxValue <= 500) return (((maxValue / 50).ceil() * 50.0) + 25.0, 50.0);
  if (maxValue <= 1000) return (((maxValue / 100).ceil() * 100.0) + 50.0, 100.0);
  final magnitude = pow(10, (log(maxValue) / ln10).floor()).toDouble();
  final interval = magnitude / 2;
  final niceMax = (maxValue / interval).ceil() * interval + interval;
  return (niceMax, interval);
}

FlTitlesData _chartTitles(
  List<DashboardDailyMetric> days,
  ThemeData theme, {
  required double interval,
  required double maxY,
}) => FlTitlesData(
  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  leftTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      interval: interval,
      reservedSize: chartAxisReservedSize,
      getTitlesWidget: (value, meta) {
        if (value < 0 || value > maxY) {
          return const SizedBox.shrink();
        }
        return SideTitleWidget(
          meta: meta,
          child: Text(
            value.toInt().toString(),
            style: theme.textTheme.labelSmall,
          ),
        );
      },
    ),
  ),
  bottomTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: chartBottomReservedSize,
      getTitlesWidget: (value, meta) {
        final index = value.toInt();
        if (index < 0 || index >= days.length || value != index) {
          return const SizedBox.shrink();
        }
        if (days.length <= 7) {
          return SideTitleWidget(
            meta: meta,
            child: Text(
              _weekdayLabelKey(days[index].date.weekday).tr(),
              style: theme.textTheme.labelSmall,
            ),
          );
        }
        if (days.length <= 14) {
          if (index % 2 != 0) {
            return const SizedBox.shrink();
          }
          return SideTitleWidget(
            meta: meta,
            child: Text(
              '${days[index].date.day} ${_monthLabelKey(days[index].date.month).tr()}',
              style: theme.textTheme.labelSmall,
            ),
          );
        }
        // 30 days
        if (index % 5 != 0) {
          return const SizedBox.shrink();
        }
        return SideTitleWidget(
          meta: meta,
          child: Text(
            '${days[index].date.day} ${_monthLabelKey(days[index].date.month).tr()}',
            style: theme.textTheme.labelSmall,
          ),
        );
      },
    ),
  ),
);

String _weekdayLabelKey(int weekday) =>
    WEEKDAY_LOCALIZATION_KEYS[weekday - DateTime.monday];

String _monthLabelKey(int month) => MONTH_LOCALIZATION_KEYS[month - 1];
