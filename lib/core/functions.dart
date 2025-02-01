import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

bool isFirstLetterUppercase(String value) {
  if (value.isEmpty) {
    return false;
  } else {
    return value[0].toUpperCase() == value[0];
  }
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return tr('email_required');
  }
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!emailRegex.hasMatch(value)) {
    return tr('email_invalid');
  }
  return null;
}

String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return tr('username_required');
  }
  if (!isFirstLetterUppercase(value)) {
    return tr('username_valid');
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return tr('password_required');
  }
  if (value.length < 6) {
    return tr('password_min');
  }
  return null;
}

String? confirmPassword(
    TextEditingController passwordController, String? value) {
  if (passwordController.value.text != value) {
    return tr('password_match');
  }
  return null;
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

String? validateUserDate(String? value) {
  if (value == null || value.isEmpty) {
    return tr('field_required');  
  }
  return null;
}

String? validatePhoneNuber(String? value) {
  if (value == null || value.isEmpty) {
    return tr('phone_required');
  }
  if (value.length!=11) {
    return tr('phone_invalid');
  }
  return null;
}
String? validateAge(String? value) {
  if (value == null || value.isEmpty) {
    return tr('age_required');
  }
  if (value.length!=2) {
    return tr('age_invalid');
  }
  return null;
}
