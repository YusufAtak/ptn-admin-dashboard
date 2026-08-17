import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ptn_admin_dashboard/domain/entities/admin_user_summary.dart';
import 'package:ptn_admin_dashboard/domain/entities/dashboard_metrics.dart';
import 'package:ptn_admin_dashboard/presentation/pages/dashboard_page.dart';
import 'package:ptn_admin_dashboard/presentation/providers/dashboard_provider.dart';

void main() {
  final referenceDate = DateTime(2026, 8, 17);
  final weeklyMetrics = DashboardWeeklyMetrics(
    todayRideCount: 8,
    days: List.generate(
      7,
      (index) => DashboardDailyMetric(
        date: referenceDate.subtract(Duration(days: 6 - index)),
        rideCount: index + 2,
        revenue: (index + 1) * 12.5,
      ),
    ),
  );

  final users = [
    const AdminUserSummary(
      id: '1234567890',
      email: 'passenger@example.com',
      displayName: 'Test Passenger',
      role: 'passenger',
      userType: 'QKGkuQo7ifAGU4mVn0bx',
      balance: 125,
    ),
  ];

  Future<void> pumpDashboard(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          totalUserCountProvider.overrideWith((ref) => Stream.value(42)),
          totalWalletBalanceProvider.overrideWith((ref) => Stream.value(2500)),
          totalRevenueProvider.overrideWith((ref) => Stream.value(780)),
          weeklyMetricsProvider.overrideWith(
            (ref) => Stream.value(weeklyMetrics),
          ),
          dashboardUsersProvider.overrideWith((ref) => Stream.value(users)),
          userTypesProvider.overrideWith(
            (ref) => Stream.value(const {
              'QKGkuQo7ifAGU4mVn0bx': 'Tam',
              '3mg1KVLvucJvCST6Uj8Y': 'Öğrenci',
              'VrkE28U4RtDA88R3wIw5': 'Yaşlı',
            }),
          ),
        ],
        child: const MaterialApp(home: DashboardPage()),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
  }

  testWidgets('renders live cards and charts on desktop', (tester) async {
    await pumpDashboard(tester, const Size(1440, 1000));

    expect(find.text('Toplam Kullanıcı'), findsOneWidget);
    expect(find.text('Bugünkü Biniş'), findsOneWidget);
    expect(find.text('Toplam Bakiye'), findsOneWidget);
    expect(find.text('Toplam Ciro'), findsOneWidget);
    expect(find.text('Günlük Binişler'), findsOneWidget);
    expect(find.text('Günlük Ciro'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders responsive content on mobile width', (tester) async {
    await pumpDashboard(tester, const Size(390, 844));

    expect(find.text('Toplam Kullanıcı'), findsOneWidget);
    expect(find.text('Canlı'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
