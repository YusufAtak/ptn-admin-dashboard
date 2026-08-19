import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/sizes.dart';
import '../../theme/theme_provider.dart';

class ThemeSwitchButton extends ConsumerWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return IconButton(
      icon: Icon(
        isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        size: iconButton,
      ),
      tooltip: isDark
          ? 'dashboard.theme_light'.tr()
          : 'dashboard.theme_dark'.tr(),
      onPressed: ref.read(themeModeProvider.notifier).toggleTheme,
    );
  }
}
