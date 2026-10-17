import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:news_app/features/onboarding/models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController pageController = PageController();

  void _onFinish(BuildContext context) async {
    await PreferencesManager().setBool(StorageKey.onboardingComplete, true);

    if (!context.mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFF5F5F5),
            actions: [
              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  return state.isLastPage
                      ? const SizedBox()
                      : TextButton(
                          onPressed: () {
                            _onFinish(context);
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: AppSizes.sp14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'times',
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
          body: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.h16),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        controller: pageController,
                        itemCount: 3,
                        onPageChanged: (int index) {
                          context.read<OnboardingCubit>().setCurrentIndex(index);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(OnboardingModel.onboardingList[index].imagePath),
                              SizedBox(height: AppSizes.h24),
                              Text(
                                OnboardingModel.onboardingList[index].title,
                                style: TextStyle(
                                  color: Color(0xFF4E4B66),
                                  fontSize: AppSizes.sp20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'times',
                                ),
                              ),
                              SizedBox(height: AppSizes.h12),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
                                child: Text(
                                  OnboardingModel.onboardingList[index].description,

                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF6E7191),
                                    fontSize: AppSizes.sp16,
                                    fontFamily: 'times',
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: pageController, // PageController
                      count: 3,
                      effect: SwapEffect(
                        dotColor: Color(0xFFD3D3D3),
                        activeDotColor: Color(0xFFC53030),
                      ), // your preferred effect
                      onDotClicked: (index) {},
                    ),
                    const Gap(114),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          if (state.isLastPage) {
                            _onFinish(context);
                          } else {
                            pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width, AppSizes.h48),
                        ),

                        child: Text(
                          state.isLastPage ? 'Get Started' : 'Next',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'times',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
