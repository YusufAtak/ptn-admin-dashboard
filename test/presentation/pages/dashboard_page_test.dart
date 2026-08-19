import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ptn_admin_dashboard/constants/locales.dart';
import 'package:ptn_admin_dashboard/core/localization/locale_provider.dart';
import 'package:ptn_admin_dashboard/core/theme/theme_provider.dart';
import 'package:ptn_admin_dashboard/features/auth/presentation/providers/auth_provider.dart';
import 'package:ptn_admin_dashboard/features/auth/presentation/providers/auth_state.dart';
import 'package:ptn_admin_dashboard/features/dashboard/domain/entities/admin_user_summary.dart';
import 'package:ptn_admin_dashboard/features/dashboard/domain/entities/dashboard_metrics.dart';
import 'package:ptn_admin_dashboard/features/dashboard/domain/entities/dashboard_snapshot.dart';
import 'package:ptn_admin_dashboard/features/dashboard/domain/entities/user_type_option.dart';
import 'package:ptn_admin_dashboard/features/dashboard/domain/enums/user_type_code.dart';
import 'package:ptn_admin_dashboard/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:ptn_admin_dashboard/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:ptn_admin_dashboard/features/dashboard/presentation/providers/dashboard_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  final referenceDate = DateTime(2026, 8, 17);
  final snapshot = DashboardSnapshot(
    totalUserCount: 42,
    totalWalletBalance: 2500,
    totalRevenue: 780,
    weeklyMetrics: DashboardWeeklyMetrics(
      todayRideCount: 8,
      days: List.generate(
        7,
        (index) => DashboardDailyMetric(
          date: referenceDate.subtract(Duration(days: 6 - index)),
          rideCount: index + 2,
          revenue: (index + 1) * 12.5,
        ),
      ),
    ),
    users: const [
      AdminUserSummary(
        id: '1234567890',
        email: 'passenger@example.com',
        displayName: 'Test Passenger',
        role: 'passenger',
        userTypeId: 'full-id',
        balance: 125,
      ),
    ],
    userTypes: const [
      UserTypeOption(id: 'full-id', code: UserTypeCode.full),
      UserTypeOption(id: 'student-id', code: UserTypeCode.student),
      UserTypeOption(id: 'elderly-id', code: UserTypeCode.elderly),
    ],
  );

  Future<void> pumpDashboard(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: SUPPORTED_LOCALES,
        path: LANGUAGE_PATH,
        fallbackLocale: TR_LOCALE,
        startLocale: TR_LOCALE,
        useOnlyLangCode: true,
        assetLoader: const _TestJsonAssetLoader(),
        child: ProviderScope(
          overrides: [
            authProvider.overrideWith(_FakeAuthNotifier.new),
            dashboardProvider.overrideWith(
              () => _FakeDashboardNotifier(snapshot),
            ),
          ],
          child: Consumer(
            builder: (context, ref, child) {
              final themeMode = ref.watch(themeModeProvider);
              final locale = ref.watch(localeProvider);
              return MaterialApp(
                locale: locale,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: themeMode,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                home: const DashboardPage(),
              );
            },
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
  }

  testWidgets('renders, changes language, toggles theme, and responds to mobile width', (
    tester,
  ) async {
    await pumpDashboard(tester, const Size(1440, 1000));

    expect(find.text('Toplam Kullanıcı'), findsOneWidget);
    expect(find.text('Bugünkü Biniş'), findsOneWidget);
    expect(find.text('Günlük Binişler'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);

    // Theme toggle test
    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    await tester.tap(find.byIcon(Icons.light_mode_outlined));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CheckedPopupMenuItem<Locale>).last);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Total Users'), findsOneWidget);

    tester.view.physicalSize = const Size(390, 844);
    await tester.pumpAndSettle();
    expect(find.byTooltip('Live'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _FakeAuthNotifier extends AuthNotifier {
  @override
  AuthState build() => const AuthState.authenticated();

  @override
  Future<void> logout() async {}
}

class _FakeDashboardNotifier extends DashboardNotifier {
  final DashboardSnapshot snapshot;

  _FakeDashboardNotifier(this.snapshot);

  @override
  DashboardState build() => DashboardState.data(snapshot: snapshot);

  @override
  Future<void> refresh() async {}

  @override
  Future<void> updateUserType(String userId, String userTypeId) async {}
}

class _TestJsonAssetLoader extends AssetLoader {
  const _TestJsonAssetLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    final content = File(
      '$path/${locale.languageCode}.json',
    ).readAsStringSync();
    return jsonDecode(content) as Map<String, dynamic>;
  }
}
