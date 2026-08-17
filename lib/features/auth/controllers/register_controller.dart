import 'package:flutter/material.dart';
import 'package:news_app/features/auth/login_screen.dart';

class RegisterController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  void signIn(BuildContext context) {
    if (key.currentState?.validate() ?? false) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  void signUp(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    } else if (!value.trim().contains('@')) {
      return 'Enter Valid Email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    } else if (value.trim().length < 6) {
      return 'The Password must be grater than 6.';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    } else if (value.trim().length < 6 &&
        value.trim() != passwordController.text) {
      return 'Enter correct Confirm Password';
    }
    return null;
  }
}
