import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import '../../constants/text_styles.dart';
import 'dashboard_theme_colors.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(seedColor: PRIMARY);

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: BG_COLOR,
      appBarTheme: const AppBarTheme(
        backgroundColor: LIGHT_BLUE,
        foregroundColor: DARK_BLUE,
      ),
      cardTheme: CardThemeData(
        color: WHITE,
        elevation: smallGap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
      ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: headlineSmall.copyWith(color: TEXT_COLOR),
        dataTextStyle: bodyMedium.copyWith(color: DARK_BLUE),
      ),
      textTheme: TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      ),
      extensions: const [DashboardThemeColors.light],
    );
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: PRIMARY,
      brightness: Brightness.dark,
      surface: CARD_BG,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: DARK_BG,
      appBarTheme: const AppBarTheme(
        backgroundColor: CARD_BG,
        foregroundColor: WHITE,
      ),
      cardTheme: CardThemeData(
        color: CARD_BG,
        elevation: smallGap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
      ),
      dataTableTheme: DataTableThemeData(
        headingTextStyle: headlineSmall.copyWith(color: LABEL_GRAY),
        dataTextStyle: bodyMedium.copyWith(color: WHITE),
      ),
      textTheme: TextTheme(
        displayLarge: displayLarge.copyWith(color: WHITE),
        displayMedium: displayMedium.copyWith(color: WHITE),
        displaySmall: displaySmall.copyWith(color: WHITE),
        headlineLarge: headlineLarge.copyWith(color: WHITE),
        headlineMedium: headlineMedium.copyWith(color: WHITE),
        headlineSmall: headlineSmall.copyWith(color: WHITE),
        titleLarge: titleLarge.copyWith(color: WHITE),
        titleMedium: titleMedium.copyWith(color: WHITE),
        titleSmall: titleSmall.copyWith(color: WHITE),
        bodyLarge: bodyLarge.copyWith(color: WHITE),
        bodyMedium: bodyMedium.copyWith(color: WHITE),
        bodySmall: bodySmall.copyWith(color: WHITE),
        labelLarge: labelLarge.copyWith(color: LABEL_GRAY),
        labelMedium: labelMedium.copyWith(color: LABEL_GRAY),
        labelSmall: labelSmall.copyWith(color: LABEL_GRAY),
      ),
      extensions: const [DashboardThemeColors.dark],
    );
  }
}
