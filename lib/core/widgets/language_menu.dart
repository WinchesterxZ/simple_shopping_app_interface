import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LangageMenu extends StatelessWidget {
  const LangageMenu({super.key, required this.screenContext});
  final BuildContext screenContext;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: const Locale('en', 'US'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Image(
                image: AssetImage('assets/images/us.png'),
                width: 30,
                height: 30,
              ),
              Text('English', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
        PopupMenuItem(
          value: const Locale('ar', 'EG'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Image(
                image: AssetImage('assets/images/eg.png'),
                width: 30,
                height: 30,
              ),
              Text('العربية', style: TextStyle(fontSize: 23)),
            ],
          ),
        ),
      ],
      icon: const Icon(Icons.language),
      onSelected: (Locale locale) {
        screenContext.setLocale(locale);
      },
    );
  }
}