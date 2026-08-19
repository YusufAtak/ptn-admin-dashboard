import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/locales.dart';
import '../../../constants/sizes.dart';
import '../../localization/locale_provider.dart';

class LanguageSwitchButton extends ConsumerWidget {
  const LanguageSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return PopupMenuButton<Locale>(
      tooltip: 'language.choose'.tr(),
      icon: const Icon(Icons.language, size: iconButton),
      onSelected: (locale) =>
          ref.read(localeProvider.notifier).setLocale(context, locale),
      itemBuilder: (context) => LOCALE_OPTIONS
          .map(
            (option) => CheckedPopupMenuItem<Locale>(
              value: option.locale,
              checked: currentLocale == option.locale,
              child: Text(option.labelKey.tr()),
            ),
          )
          .toList(growable: false),
    );
  }
}
