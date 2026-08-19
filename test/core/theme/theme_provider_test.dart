import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ptn_admin_dashboard/core/di/locator.dart';
import 'package:ptn_admin_dashboard/core/theme/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    if (getIt.isRegistered<SharedPreferences>()) {
      await getIt.unregister<SharedPreferences>();
    }
  });

  test('defaults to ThemeMode.dark when no preference is stored', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(prefs);

    final container = ProviderContainer();
    addTearDown(container.dispose);

    final mode = container.read(themeModeProvider);
    expect(mode, ThemeMode.dark);
  });

  test('restores ThemeMode.light when previously saved in SharedPreferences', () async {
    SharedPreferences.setMockInitialValues({
      ThemeModeNotifier.themeStorageKey: 'light',
    });
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(prefs);

    final container = ProviderContainer();
    addTearDown(container.dispose);

    final mode = container.read(themeModeProvider);
    expect(mode, ThemeMode.light);
  });

  test('toggles theme and saves to SharedPreferences', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(prefs);

    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(themeModeProvider), ThemeMode.dark);

    await container.read(themeModeProvider.notifier).toggleTheme();
    expect(container.read(themeModeProvider), ThemeMode.light);
    expect(prefs.getString(ThemeModeNotifier.themeStorageKey), 'light');

    await container.read(themeModeProvider.notifier).toggleTheme();
    expect(container.read(themeModeProvider), ThemeMode.dark);
    expect(prefs.getString(ThemeModeNotifier.themeStorageKey), 'dark');
  });
}
