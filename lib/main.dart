import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_interface/feature/addUser/user_data.dart';
import 'package:shopping_app_interface/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'), // english
        Locale('ar', 'EG'), // arabic
      ],
      path: "lang",
      fallbackLocale: Locale('en',
          'US'), // if the locale is not supported or  when the locale is not in the list
      child: const MyApp(),
    ),
  ); // Entry point of the app
}

// This class represents the main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Return a MaterialApp widget that contains the main home page widget
    return MaterialApp(
      debugShowCheckedModeBanner: false, // hide the debug banner.
      localizationsDelegates: context
          .localizationDelegates, // list of delegates that can provide localized values
      supportedLocales:
          context.supportedLocales, // list of locales that the app supports
      locale: context.locale, // current locale of the app
      home: AddUserScreen(), // Set MyHomePage as the home widget
    );
  }
}
