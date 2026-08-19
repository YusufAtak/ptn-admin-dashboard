// ignore_for_file: constant_identifier_names

import 'dart:ui';

const TR_LOCALE = Locale('tr', 'TR');
const EN_LOCALE = Locale('en', 'US');

const SUPPORTED_LOCALES = [TR_LOCALE, EN_LOCALE];
const String LANGUAGE_PATH = 'assets/lang';

typedef AppLocaleOption = ({Locale locale, String labelKey});

const List<AppLocaleOption> LOCALE_OPTIONS = [
  (locale: TR_LOCALE, labelKey: 'language.turkish'),
  (locale: EN_LOCALE, labelKey: 'language.english'),
];
