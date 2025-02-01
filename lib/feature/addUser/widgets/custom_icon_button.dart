import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({
    super.key,
    required this.onTap,
    required this.iconPath,
  });

  final GestureTapCallback? onTap;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // Played around with these values to get that subtle elevation look xD
              color: Colors.black.withValues(alpha: 0.2), // Shadow color
              offset: const Offset(0, 4), // Shadow position
              blurRadius: 8, // Shadow blur radius
              spreadRadius: 2, // Shadow spread radius
            ),
          ],
        ),
        child: Image(
          image: AssetImage(iconPath),
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
