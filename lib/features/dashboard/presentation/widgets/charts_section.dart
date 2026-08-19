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
  final DashboardWeeklyMetrics metrics;

  const ChartsSection({required this.metrics, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= breakpointChartWide;
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
              child: _RideBarChart(days: metrics.days),
            ),
            _ChartCard(
              width: chartWidth,
              titleKey: 'dashboard.daily_revenue',
              subtitleKey: 'dashboard.wallet_rides',
              child: _RevenueLineChart(days: metrics.days),
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

  const _ChartCard({
    required this.width,
    required this.titleKey,
    required this.subtitleKey,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(chartCardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titleKey.tr(), style: theme.textTheme.headlineLarge),
              const SizedBox(height: smallGap),
              Text(subtitleKey.tr(), style: theme.textTheme.labelMedium),
              const SizedBox(height: pagePadding),
              SizedBox(height: chartHeight, child: child),
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

    return BarChart(
      BarChartData(
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
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.colorScheme.onSurface.withValues(alpha: SHADOW),
            strokeWidth: 1,
          ),
        ),
        titlesData: _chartTitles(days, theme),
        barGroups: [
          for (var index = 0; index < days.length; index++)
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: days[index].rideCount.toDouble(),
                  width: chartBarWidth,
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

    return LineChart(
      LineChartData(
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
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.colorScheme.onSurface.withValues(alpha: SHADOW),
            strokeWidth: 1,
          ),
        ),
        titlesData: _chartTitles(days, theme),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var index = 0; index < days.length; index++)
                FlSpot(index.toDouble(), days[index].revenue),
            ],
            isCurved: true,
            barWidth: chartLineWidth,
            color: dashboardColors.revenue,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: dashboardColors.revenue.withValues(
                alpha: CHART_AREA,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

FlTitlesData _chartTitles(List<DashboardDailyMetric> days, ThemeData theme) =>
    FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: chartAxisReservedSize,
          getTitlesWidget: (value, meta) => SideTitleWidget(
            meta: meta,
            child: Text(
              value.toInt().toString(),
              style: theme.textTheme.labelSmall,
            ),
          ),
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
            return SideTitleWidget(
              meta: meta,
              child: Text(
                _weekdayLabelKey(days[index].date.weekday).tr(),
                style: theme.textTheme.labelSmall,
              ),
            );
          },
        ),
      ),
    );

String _weekdayLabelKey(int weekday) =>
    WEEKDAY_LOCALIZATION_KEYS[weekday - DateTime.monday];
