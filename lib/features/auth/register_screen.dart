import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/controllers/register_controller.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterController>(
      create: (_) => RegisterController(),
      builder: (context, _) {
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
              child: LayoutBuilder(
                builder: (BuildContext _, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Image.asset('assets/images/logo.png', height: 46)),
                            const Gap(34),
                            Text(
                              'Welcome to Newts',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF363636),
                              ),
                            ),
                            const Gap(24),
                            CustomTextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.emailController,
                              hintText: 'usama@gmail.com',
                              title: 'Email',
                              validator: controller.validateEmail,
                            ),
                            const Gap(24),
                            CustomTextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: controller.passwordController,
                              hintText: '*************',
                              title: 'Password',
                              obscureText: true,
                              validator: controller.validatePassword,
                            ),
                            const Gap(24),
                            CustomTextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: controller.confirmPasswordController,
                              hintText: '*************',
                              title: 'Confirm Password',
                              obscureText: true,
                              validator: controller.validateConfirmPassword,
                            ),
                            Selector<RegisterController, String?>(
                              selector: (_, controller) => controller.errorMessage,
                              builder: (context, errorMessage, _) {
                                return (errorMessage == null)
                                    ? SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          errorMessage,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFFC62828),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                              },
                            ),
                            const Gap(20),
                            Selector<RegisterController, bool>(
                              selector: (BuildContext _, controller) => controller.isLoading,
                              builder: (BuildContext context, bool isLoading, Widget? _) {
                                return ElevatedButton(
                                  onPressed: () {
                                    if (controller.key.currentState!.validate()) {
                                      controller.register(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(MediaQuery.of(context).size.width, 48),
                                  ),
                                  child: isLoading
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : Text("Sign Up"),
                                );
                              },
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
                                const Gap(8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
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
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
