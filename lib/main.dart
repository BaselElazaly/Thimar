// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/cache/cache_helper.dart';
import 'package:thimar/core/route/routes.dart';
import 'package:thimar/core/services/local_cubit.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/firebase_options.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  setupLocator();

 runApp(
    BlocProvider(
      create: (context) => LocaleCubit(), 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: locale, 
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: AppColors.primary,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppColors.primary,
              selectionHandleColor: AppColors.primary,
              selectionColor: Color(0x4D4C8613),
            ),
            fontFamily: 'Tajawal',
          ),
          onGenerateRoute: AppRouter().generateRoute,
          initialRoute: Routes.splashView,
        );
      },
    );
  }
}