
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
    return 'Email is required';
  }
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Username is required';
  }
  if (!isFirstLetterUppercase(value)) {
    return 'Username must start with a capital letter';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  // Add more conditions for password strength if needed
  return null;
}

String? confirmPassword(
    TextEditingController passwordController, String? value) {
  if (passwordController.value.text != value) {
    return 'Passwords do not match';
  }
  // Add more conditions for password strength if needed
  return null;
}
