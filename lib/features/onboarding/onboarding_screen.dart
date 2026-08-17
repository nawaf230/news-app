import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:news_app/features/onboarding/models/onboarding_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
    return ChangeNotifierProvider<OnboardingController>(
      create: (_) => OnboardingController(),
      builder: (context, _) {
        final OnboardingController controller = context.read();
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFF5F5F5),
              actions: [
                Consumer<OnboardingController>(
                  builder: (context, OnboardingController controller1, _) {
                    return controller.isLastPage
                        ? const SizedBox()
                        : TextButton(
                            onPressed: () {
                              _onFinish(context);
                            },
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      itemCount: 3,
                      onPageChanged: (int index) {
                        controller.setCurrentIndex(index);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              OnboardingModel.onboardingList[index].imagePath,
                            ),
                            const Gap(24),
                            Text(
                              OnboardingModel.onboardingList[index].title,
                              style: TextStyle(
                                color: Color(0xFF4E4B66),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Gap(12),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                OnboardingModel
                                    .onboardingList[index]
                                    .description,

                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF6E7191),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller.pageController, // PageController
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
                        if (controller.isLastPage) {
                          _onFinish(context);
                        } else {
                          controller.pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 48),
                      ),
                      child: Consumer<OnboardingController>(
                        builder: (context, OnboardingController controller, _) {
                          return controller.isLastPage
                              ? Text('Get Started')
                              : Text('Next');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
