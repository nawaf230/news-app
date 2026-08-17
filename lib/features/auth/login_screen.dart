import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/controllers/login_controller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>(
      create: (_) => LoginController(),
      builder: (context, _) {
        final controller = context.read<LoginController>();

        return Scaffold(
          body: Form(
            key: controller.key,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_image.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset('assets/images/logo.png', height: 46),
                    ),
                    const Gap(34),
                    Text(
                      'Welcome to Newts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF363636),
                      ),
                    ),
                    const Gap(16),
                    CustomTextFormField(
                      controller: controller.emailController,
                      hintText: 'usama@gmail.com',
                      title: 'Email',
                      validator: (value) {
                        return controller.validateEmail(value);
                      },
                    ),
                    const Gap(12),
                    CustomTextFormField(
                      controller: controller.passwordController,
                      hintText: '*************',
                      title: 'Password',
                      validator: (value) {
                        return controller.validatePassword(value);
                      },
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () {
                        controller.signIn(context);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 48),
                      ),
                      child: Text("Sign In"),
                    ),
                    const Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account ?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF141414),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.signUp(context);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: LightColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
