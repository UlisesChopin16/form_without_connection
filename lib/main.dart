import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_connection/app/app.dart';
import 'package:form_without_connection/app/dep_inject.dart';
import 'package:form_without_connection/constants/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [ENGLISH_LOCAL, ARABIC_LOCAL, SPANISH_LOCAL],
        path: ASSETS_PATH_LOCALISATIONS,
        child: const MyApp(),
      ),
    ),
  );
}
