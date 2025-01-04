import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_interface/feature/signup/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', 'EG'),
      ],
      path: "lang",
      fallbackLocale: Locale('ar', 'EG'),
      child: const MyApp(),
    ),
  ); // Entry point of the app
}

// This class represents the main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale('ar', 'EG'));
    // Return a MaterialApp widget that contains the main home page widget
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SignupScreen(), // Set MyHomePage as the home widget
    );
  }
}
