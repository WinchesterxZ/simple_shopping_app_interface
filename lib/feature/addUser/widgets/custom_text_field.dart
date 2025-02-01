import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.obscureText,
      required this.labelText,
      required this.validator,
      this.suffixIcon, required TextInputType keyboardType});

  final TextEditingController? controller;
  final bool? obscureText;
  final String labelText;
  final Widget? suffixIcon;
  final String? Function(String?) validator;
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          suffixIcon: suffixIcon),
          validator: validator,
    );
  }
}
