import 'package:flutter/material.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/main/main_screen.dart';

class RegisterController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;

  void register(BuildContext context) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    // This code means wait 3s.
    await Future.delayed(Duration(seconds: 2));

    final saveEmail = PreferencesManager().getString(StorageKey.userEmail);
    if (saveEmail != null && emailController.text.trim() == saveEmail) {
      errorMessage = "User Already Register.";
      isLoading = false;
      notifyListeners();
    } else {
      await PreferencesManager().setString(
        StorageKey.userEmail,
        emailController.text.trim(),
      );
      await PreferencesManager().setString(
        StorageKey.userPassword,
        passwordController.text.trim(),
      );
      await PreferencesManager().setBool(StorageKey.isLoggedIn, true);

      if (!context.mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    if (!passwordRegex.hasMatch(value)) {
      return 'Password is too weak. It must contain at least 8 characters, an uppercase letter, a lowercase letter, a number, and a special character';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value != passwordController.text) {
      return 'Incorrect Password';
    }

    return null;
  }
}
