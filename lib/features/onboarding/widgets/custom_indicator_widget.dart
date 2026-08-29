import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:provider/provider.dart';

class CustomIndicatorWidget extends StatelessWidget {
  const CustomIndicatorWidget({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<OnboardingController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(count, growable: false, (index) {
        return Container(
          height: AppSizes.h16,
          width: AppSizes.w16,
          margin: EdgeInsets.symmetric(horizontal: AppSizes.w3),
          decoration: BoxDecoration(
            color: controller.currentIndex == index ? Color(0xFFC53030) : Color(
                0xFFD3D3D3),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
