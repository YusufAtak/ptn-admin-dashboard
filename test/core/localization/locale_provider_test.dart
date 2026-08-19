import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ptn_admin_dashboard/constants/locales.dart';
import 'package:ptn_admin_dashboard/core/localization/locale_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  test('defaults to TR_LOCALE initially', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final locale = container.read(localeProvider);
    expect(locale, TR_LOCALE);
  });

  testWidgets('updates state and delegates to EasyLocalization setLocale', (tester) async {
    late BuildContext savedContext;
    late WidgetRef savedRef;

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: SUPPORTED_LOCALES,
        path: LANGUAGE_PATH,
        fallbackLocale: TR_LOCALE,
        startLocale: TR_LOCALE,
        useOnlyLangCode: true,
        assetLoader: const _TestJsonAssetLoader(),
        child: ProviderScope(
          child: Consumer(
            builder: (context, ref, child) {
              savedContext = context;
              savedRef = ref;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(savedRef.read(localeProvider), TR_LOCALE);

    await savedRef.read(localeProvider.notifier).setLocale(savedContext, EN_LOCALE);
    await tester.pumpAndSettle();

    expect(savedRef.read(localeProvider), EN_LOCALE);
  });
}

class _TestJsonAssetLoader extends AssetLoader {
  const _TestJsonAssetLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    return {'dashboard': {'title': 'Dashboard'}};
  }
}
