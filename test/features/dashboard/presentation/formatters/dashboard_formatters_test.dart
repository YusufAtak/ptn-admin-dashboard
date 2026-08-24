import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ptn_admin_dashboard/constants/locales.dart';
import 'package:ptn_admin_dashboard/features/dashboard/presentation/formatters/dashboard_formatters.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets(
      'formatCurrency formats numbers using Turkish thousand and decimal separators',
      (tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: SUPPORTED_LOCALES,
        path: LANGUAGE_PATH,
        fallbackLocale: TR_LOCALE,
        startLocale: TR_LOCALE,
        useOnlyLangCode: true,
        assetLoader: const _TestJsonAssetLoader(),
        child: Builder(
          builder: (context) {
            return MaterialApp(
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              home: Builder(
                builder: (context) {
                  final formattedLarge = formatCurrency(16171.50);
                  final formattedSmall = formatCurrency(614.50);
                  final formattedZero = formatCurrency(0.0);

                  expect(formattedLarge, '₺16.171,50');
                  expect(formattedSmall, '₺614,50');
                  expect(formattedZero, '₺0,00');

                  return const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
  });
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
