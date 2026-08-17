import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firestore_constants.dart';
import '../../domain/entities/admin_user_summary.dart';
import '../../domain/entities/dashboard_metrics.dart';
import '../providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalUsers = ref.watch(totalUserCountProvider);
    final totalBalance = ref.watch(totalWalletBalanceProvider);
    final totalRevenue = ref.watch(totalRevenueProvider);
    final weeklyMetrics = ref.watch(weeklyMetricsProvider);
    final users = ref.watch(dashboardUsersProvider);
    final userTypes = ref.watch(userTypesProvider);

    final errorKey =
        _errorKey(totalUsers) ??
        _errorKey(totalBalance) ??
        _errorKey(totalRevenue) ??
        _errorKey(weeklyMetrics) ??
        _errorKey(users) ??
        _errorKey(userTypes);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Chip(
              avatar: Icon(Icons.circle, color: Colors.green, size: 12),
              label: Text('Canlı'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => refreshDashboard(ref),
            tooltip: 'Akışları yeniden bağla',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
            tooltip: 'Çıkış Yap',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (errorKey != null) ...[
              _DashboardErrorBanner(
                message: _dashboardErrorText(errorKey),
                onRetry: () => refreshDashboard(ref),
              ),
              const SizedBox(height: 24),
            ],
            _SummaryCards(
              totalUsers: totalUsers,
              totalBalance: totalBalance,
              totalRevenue: totalRevenue,
              weeklyMetrics: weeklyMetrics,
            ),
            const SizedBox(height: 32),
            const Text(
              'Son 7 Gün',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _ChartsSection(metrics: weeklyMetrics),
            const SizedBox(height: 40),
            const Text(
              'Son Kayıt Olan Kullanıcılar (Maks 100)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _UserTable(users: users, userTypes: userTypes),
          ],
        ),
      ),
    );
  }

  String? _errorKey(AsyncValue<dynamic> value) {
    final error = value.error;
    return switch (error) {
      DashboardStreamException(:final messageKey) => messageKey,
      null => null,
      _ => 'dashboard.unknown_error',
    };
  }
}

class _SummaryCards extends StatelessWidget {
  final AsyncValue<int> totalUsers;
  final AsyncValue<double> totalBalance;
  final AsyncValue<double> totalRevenue;
  final AsyncValue<DashboardWeeklyMetrics> weeklyMetrics;

  const _SummaryCards({
    required this.totalUsers,
    required this.totalBalance,
    required this.totalRevenue,
    required this.weeklyMetrics,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1100
            ? 4
            : constraints.maxWidth >= 600
            ? 2
            : 1;
        final cardWidth =
            (constraints.maxWidth - ((columns - 1) * 16)) / columns;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _SummaryCard(
              title: 'Toplam Kullanıcı',
              value: totalUsers.when(
                data: (value) => value.toString(),
                error: (_, _) => '—',
                loading: () => '…',
              ),
              icon: Icons.people,
              color: Colors.blue,
              width: cardWidth,
            ),
            _SummaryCard(
              title: 'Bugünkü Biniş',
              value: weeklyMetrics.when(
                data: (value) => value.todayRideCount.toString(),
                error: (_, _) => '—',
                loading: () => '…',
              ),
              icon: Icons.directions_bus,
              color: Colors.green,
              width: cardWidth,
            ),
            _SummaryCard(
              title: 'Toplam Bakiye',
              value: totalBalance.when(
                data: (value) => '₺${value.toStringAsFixed(2)}',
                error: (_, _) => '—',
                loading: () => '…',
              ),
              icon: Icons.account_balance_wallet,
              color: Colors.purple,
              width: cardWidth,
            ),
            _SummaryCard(
              title: 'Toplam Ciro',
              value: totalRevenue.when(
                data: (value) => '₺${value.toStringAsFixed(2)}',
                error: (_, _) => '—',
                loading: () => '…',
              ),
              icon: Icons.payments,
              color: Colors.orange,
              width: cardWidth,
            ),
          ],
        );
      },
    );
  }
}

class _ChartsSection extends StatelessWidget {
  final AsyncValue<DashboardWeeklyMetrics> metrics;

  const _ChartsSection({required this.metrics});

  @override
  Widget build(BuildContext context) {
    return metrics.when(
      loading: () => const SizedBox(
        height: 320,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => const SizedBox(
        height: 160,
        child: Center(child: Text('Grafik verileri alınamadı.')),
      ),
      data: (value) => LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          final chartWidth = isWide
              ? (constraints.maxWidth - 16) / 2
              : constraints.maxWidth;

          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _ChartCard(
                width: chartWidth,
                title: 'Günlük Binişler',
                subtitle: 'Başarılı biniş adedi',
                child: _RideBarChart(days: value.days),
              ),
              _ChartCard(
                width: chartWidth,
                title: 'Günlük Ciro',
                subtitle: 'Cüzdan ile yapılan binişler',
                child: _RevenueLineChart(days: value.days),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final double width;
  final String title;
  final String subtitle;
  final Widget child;

  const _ChartCard({
    required this.width,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          SizedBox(height: 240, child: child),
        ],
      ),
    );
  }
}

class _RideBarChart extends StatelessWidget {
  final List<DashboardDailyMetric> days;

  const _RideBarChart({required this.days});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: _chartTitles(days),
        barGroups: [
          for (var index = 0; index < days.length; index++)
            BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: days[index].rideCount.toDouble(),
                  width: 18,
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
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
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: true, drawVerticalLine: false),
        titlesData: _chartTitles(days),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var index = 0; index < days.length; index++)
                FlSpot(index.toDouble(), days[index].revenue),
            ],
            isCurved: true,
            barWidth: 3,
            color: Colors.orange,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.orange.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
    );
  }
}

FlTitlesData _chartTitles(List<DashboardDailyMetric> days) {
  return FlTitlesData(
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: true, reservedSize: 42),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 32,
        getTitlesWidget: (value, meta) {
          final index = value.toInt();
          if (index < 0 || index >= days.length || value != index) {
            return const SizedBox.shrink();
          }
          return SideTitleWidget(
            meta: meta,
            child: Text(_weekdayLabel(days[index].date.weekday)),
          );
        },
      ),
    ),
  );
}

String _weekdayLabel(int weekday) {
  const labels = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
  return labels[weekday - 1];
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double width;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserTable extends ConsumerWidget {
  final AsyncValue<List<AdminUserSummary>> users;
  final AsyncValue<Map<String, String>> userTypes;

  const _UserTable({required this.users, required this.userTypes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return users.when(
      loading: () => const SizedBox(
        height: 160,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => const SizedBox(
        height: 160,
        child: Center(child: Text('Kullanıcılar alınamadı.')),
      ),
      data: (items) {
        final typeLabels = userTypes.value ?? UserTypeIds.fallbackLabels;
        final updatingUsers = ref.watch(userTypeUpdateProvider);

        return Container(
          width: double.infinity,
          decoration: _cardDecoration,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('İsim')),
                DataColumn(label: Text('E-posta')),
                DataColumn(label: Text('Bakiye')),
                DataColumn(label: Text('Tarife (userType)')),
              ],
              rows: items
                  .map((user) {
                    return DataRow(
                      cells: [
                        DataCell(Text(_shortId(user.id))),
                        DataCell(
                          Text(
                            user.displayName.isEmpty
                                ? 'İsimsiz'
                                : user.displayName,
                          ),
                        ),
                        DataCell(Text(user.email)),
                        DataCell(Text('₺${user.balance.toStringAsFixed(2)}')),
                        DataCell(
                          DropdownButton<String>(
                            value: user.userType,
                            underline: const SizedBox.shrink(),
                            items: typeLabels.entries
                                .map(
                                  (entry) => DropdownMenuItem(
                                    value: entry.key,
                                    child: Text(entry.value),
                                  ),
                                )
                                .toList(growable: false),
                            onChanged: updatingUsers.contains(user.id)
                                ? null
                                : (newValue) async {
                                    if (newValue == null ||
                                        newValue == user.userType) {
                                      return;
                                    }
                                    final errorKey = await ref
                                        .read(userTypeUpdateProvider.notifier)
                                        .updateUserType(user.id, newValue);
                                    if (errorKey != null && context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            _dashboardErrorText(errorKey),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                          ),
                        ),
                      ],
                    );
                  })
                  .toList(growable: false),
            ),
          ),
        );
      },
    );
  }

  String _shortId(String id) {
    return id.length <= 8 ? id : '${id.substring(0, 8)}...';
  }
}

class _DashboardErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _DashboardErrorBanner({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.errorContainer,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
            TextButton(onPressed: onRetry, child: const Text('Tekrar Dene')),
          ],
        ),
      ),
    );
  }
}

BoxDecoration get _cardDecoration => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ],
);

String _dashboardErrorText(String messageKey) {
  return switch (messageKey) {
    'dashboard.permission_denied' =>
      'Firestore erişimi reddedildi. Admin rolünü ve kuralları kontrol edin.',
    'dashboard.missing_index' =>
      'Bu canlı sorgu için gerekli Firestore indeksi hazır değil.',
    'dashboard.invalid_user_type' => 'Geçersiz kullanıcı tipi seçildi.',
    'dashboard.error_updating_user' =>
      'Kullanıcı tipi güncellenemedi. Lütfen tekrar deneyin.',
    'dashboard.error_fetching_balance' => 'Toplam bakiye alınamadı.',
    'dashboard.error_fetching_revenue' => 'Toplam ciro alınamadı.',
    'dashboard.error_fetching_rides' => 'Biniş verileri alınamadı.',
    'dashboard.error_fetching_users' => 'Kullanıcı sayısı alınamadı.',
    'dashboard.error_fetching_user_list' =>
      'Kullanıcı listesi veya cüzdan bakiyeleri alınamadı.',
    'dashboard.error_fetching_user_types' =>
      'Kullanıcı tipi seçenekleri alınamadı.',
    _ => 'Dashboard verileri alınırken bir hata oluştu.',
  };
}
