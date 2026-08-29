import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/controllers/login_controller.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                padding: EdgeInsets.all(AppSizes.w16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset('assets/images/logo.png', height: 46)),
                    SizedBox(height: AppSizes.h34),
                    Text(
                      'Welcome to Newts',
                      style: TextStyle(
                        fontSize: AppSizes.sp20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF363636),
                      ),
                    ),
                    SizedBox(height: AppSizes.h24),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      hintText: 'usama@gmail.com',
                      title: 'Email',
                      validator: (value) {
                        return controller.validateEmail(value);
                      },
                    ),
                    SizedBox(height: AppSizes.h24,),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,

                      controller: controller.passwordController,
                      hintText: '*************',
                      title: 'Password',
                      validator: (value) {
                        return controller.validatePassword(value);
                      },
                      obscureText: true,
                    ),
                    Selector<LoginController, String?>(
                      selector: (_, LoginController controller) => controller.errorMessage,
                      builder: (context, errorMessage, child) {
                        return errorMessage == null
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.all(AppSizes.w8),
                                child: Text(
                                  errorMessage,
                                  style: TextStyle(
                                    fontSize: AppSizes.sp15,
                                    color: Color(0xFFC62828),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                      },
                    ),
                    const Gap(20),
                    Selector<LoginController, bool>(
                      selector: (_, controller) => controller.isLoading,
                      builder: (context, isLoading, child) {
                        return ElevatedButton(
                          onPressed: () {
                            controller.login(context);
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
                              : Text("Sign In"),
                        );
                      },
                    ),
                    const Gap(34),
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
                        const Gap(8),
                        GestureDetector(
                          onTap: () {
                            controller.toRegister(context);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor,
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
