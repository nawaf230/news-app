import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  final PageController pageController = PageController();

  int currentIndex = 0;
  bool isLastPage = false;

  void setCurrentIndex(int index) {
    currentIndex = index;
    if (currentIndex == 2) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }
    notifyListeners();
  }
}
