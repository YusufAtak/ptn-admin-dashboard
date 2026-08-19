import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../di/locator.dart';

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const String themeStorageKey = 'admin_dashboard_theme_mode';

  @override
  ThemeMode build() {
    try {
      if (getIt.isRegistered<SharedPreferences>()) {
        final prefs = getIt<SharedPreferences>();
        final saved = prefs.getString(themeStorageKey);
        if (saved == 'light') return ThemeMode.light;
        if (saved == 'dark') return ThemeMode.dark;
      }
    } catch (_) {
      // Fallback if shared preferences is not yet initialized or mocked
    }
    return ThemeMode.dark;
  }

  Future<void> toggleTheme() async {
    final nextMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = nextMode;
    try {
      if (getIt.isRegistered<SharedPreferences>()) {
        final prefs = getIt<SharedPreferences>();
        await prefs.setString(
          themeStorageKey,
          nextMode == ThemeMode.dark ? 'dark' : 'light',
        );
      }
    } catch (_) {
      // Ignore storage persistence errors gracefully
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    try {
      if (getIt.isRegistered<SharedPreferences>()) {
        final prefs = getIt<SharedPreferences>();
        await prefs.setString(
          themeStorageKey,
          mode == ThemeMode.dark ? 'dark' : 'light',
        );
      }
    } catch (_) {
      // Ignore storage persistence errors gracefully
    }
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
