import 'package:flutter/material.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/features/auth/register_screen.dart';
import 'package:news_app/features/home/home_screen.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;

  void login(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      isLoading = true;
      errorMessage = null;

      notifyListeners();

      // This code means wait 2s.
      await Future.delayed(Duration(seconds: 2));

      final savedEmail = PreferencesManager().getString(StorageKey.userEmail);
      final savedPassword = PreferencesManager().getString(StorageKey.userPassword);
      if (savedEmail == null && savedPassword == null) {
        isLoading = false;
        errorMessage = 'No Account Found Please Register First.';
        notifyListeners();
        return;
      }

      if (savedEmail != emailController.text.trim() ||
          savedPassword != passwordController.text.trim()) {
        isLoading = false;
        errorMessage = 'Incorrect Email or Password';
        notifyListeners();
        return;
      }

      await PreferencesManager().setBool(StorageKey.isLoggedIn, true);
      if (!context.mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  void toRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return RegisterScreen();
        },
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    // final passwordRegex = RegExp(
    //   r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    // );
    // if (!passwordRegex.hasMatch(value)) {
    //   return 'Password is too weak. It must contain at least 8 characters, an uppercase letter, a lowercase letter, a number, and a special character';
    // }
    return null;
  }
}
