import 'package:flutter/material.dart';
import 'package:shopping_app_interface/core/strings.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image(
                  image: AssetImage(AppStrings.logo),
                  width: 150,
                  height: 150,
                ),
              );
  }
}