import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/controllers/register_controller.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisiblePassword = false;
  bool isVisibleConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterController>(
      create: (context) => RegisterController(),
      builder: (context, child) {
        final controller = context.read<RegisterController>();

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
                      validator: controller.validateEmail,
                    ),
                    const Gap(12),
                    CustomTextFormField(
                      controller: controller.passwordController,
                      hintText: '*************',
                      title: 'Password',
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisiblePassword = !isVisiblePassword;
                          });
                        },
                        icon: isVisiblePassword
                            ? Icon(Icons.visibility_outlined)
                            : Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                    const Gap(12),
                    CustomTextFormField(
                      controller: controller.confirmPasswordController,
                      hintText: '*************',
                      title: 'Confirm Password',
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisibleConfirmPassword =
                                !isVisibleConfirmPassword;
                          });
                        },
                        icon: isVisibleConfirmPassword
                            ? Icon(Icons.visibility_outlined)
                            : Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.key.currentState!.validate()) {
                          controller.signUp(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 48),
                      ),
                      child: Text("Sign Up"),
                    ),
                    const Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account ?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF141414),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.signIn(context);
                          },
                          child: Text(
                            'Sign In',
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
