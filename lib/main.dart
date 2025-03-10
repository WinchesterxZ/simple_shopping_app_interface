import 'package:flutter/material.dart';
import 'package:shopping_app_interface/feature/shopping_screen/shopping_main_screen.dart';
import 'package:shopping_app_interface/feature/signup/signup_page.dart';

void main() {
  runApp(const MyApp()); // Entry point of the app
}

// This class represents the main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Return a MaterialApp widget that contains the main home page widget
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(), // Set MyHomePage as the home widget
    );
  }
}
