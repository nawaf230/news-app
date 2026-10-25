import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_service.dart';
import 'package:news_app/core/repos/auth_repository.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/register_screen.dart';
import 'package:news_app/features/main/main_screen.dart';
import 'package:news_app/core/enums/request_status_enum.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepository(AuthApiService())),

      child: Scaffold(
        body: Form(
          key: key,
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == RequestStatusEnum.loaded) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MainScreen()),
                );
              }
            },
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
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 46,
                          ),
                        ),
                        SizedBox(height: AppSizes.h34),
                        Text(
                          'Welcome to Newts',
                          style: TextStyle(
                            fontSize: AppSizes.sp20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF363636),
                            fontFamily: 'times',
                          ),
                        ),
                        SizedBox(height: AppSizes.h24),
                        CustomTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          hintText: 'usama@gmail.com',
                          title: 'Email',
                        ),
                        SizedBox(height: AppSizes.h24),
                        CustomTextFormField(
                          keyboardType: TextInputType.visiblePassword,

                          controller: passwordController,
                          hintText: '*************',
                          title: 'Password',
                          obscureText: true,
                        ),

                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return state.errorMessage == null
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.all(AppSizes.w8),
                                    child: Text(
                                      state.errorMessage!,
                                      style: TextStyle(
                                        fontSize: AppSizes.sp15,
                                        color: Color(0xFFC62828),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'times',
                                      ),
                                    ),
                                  );
                          },
                        ),
                        const Gap(20),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            final controller = context.read<AuthCubit>();

                            return ElevatedButton(
                              onPressed: () async {
                                await controller.login(
                                  userName: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  MediaQuery.of(context).size.width,
                                  48,
                                ),
                              ),
                              child: state.status == RequestStatusEnum.loading
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : Text(
                                      "Sign In",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'times',
                                      ),
                                    ),
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
                                fontFamily: 'times',
                              ),
                            ),
                            const Gap(8),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return RegisterScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).primaryColor,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
