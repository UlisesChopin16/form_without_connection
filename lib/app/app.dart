import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_without_connection/app/app_preferences.dart';
import 'package:form_without_connection/app/dep_inject.dart';
import 'package:form_without_connection/constants/theme_manager.dart';
import 'package:form_without_connection/presentation/routes/routes_manager.dart';
import 'package:form_without_connection/presentation/views/register/register_view.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) {
      context.setLocale(local);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: GoRouter(
        debugLogDiagnostics: true,
        initialLocation: Routes.registerRoute,
        routes: RoutesManager.routes,
      ),
    );
  }
}
