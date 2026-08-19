import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/locales.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    return TR_LOCALE;
  }

  Future<void> setLocale(BuildContext context, Locale newLocale) async {
    if (state == newLocale) return;
    state = newLocale;
    await context.setLocale(newLocale);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);
