import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'constants/locales.dart';
import 'core/di/locator.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: SUPPORTED_LOCALES,
      path: LANGUAGE_PATH,
      fallbackLocale: TR_LOCALE,
      useOnlyLangCode: true,
      child: const ProviderScope(child: MyApp()),
    ),
  );
}
