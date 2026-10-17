import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_service.dart';
import 'package:news_app/core/repos/auth_repository.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepository(AuthApiService())),

      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == RequestStatusEnum.loaded) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
          }
        },
        child: Scaffold(
          body: Form(
            key: key,
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final controller = context.read<AuthCubit>();

                return Container(
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
                                    fontFamily: 'times',
                                  ),
                                ),
                                const Gap(24),
                                CustomTextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: userNameController,
                                  hintText: 'username123',
                                  title: 'User Name',
                                  validator: validateUserName,
                                ),
                                const Gap(24),
                                CustomTextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  hintText: 'usama@gmail.com',
                                  title: 'Email',
                                  validator: validateEmail,
                                ),
                                const Gap(24),
                                CustomTextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  hintText: '*************',
                                  title: 'Password',
                                  obscureText: true,
                                  validator: validatePassword,
                                ),
                                const Gap(24),
                                CustomTextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: confirmPasswordController,
                                  hintText: '*************',
                                  title: 'Confirm Password',
                                  obscureText: true,
                                  validator: validateConfirmPassword,
                                ),

                                (state.errorMessage == null)
                                    ? SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          state.errorMessage!,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFFC62828),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'times',
                                          ),
                                        ),
                                      ),
                                const Gap(20),

                                ElevatedButton(
                                  onPressed: () async {
                                    if (key.currentState!.validate()) {
                                      await controller.register(
                                        name: userNameController.text.trim(),
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(MediaQuery.of(context).size.width, 48),
                                  ),
                                  child: state.status == RequestStatusEnum.loading
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'times',
                                          ),
                                        ),
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
                                        fontFamily: 'times',
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
                                          fontFamily: 'times',
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your User Name';
    }

    return null;
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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value != passwordController.text) {
      return 'Incorrect Password';
    }

    return null;
  }
}
