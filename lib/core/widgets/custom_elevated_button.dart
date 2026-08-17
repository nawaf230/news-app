// import 'package:flutter/material.dart';

// class CustomElevatedButton extends StatelessWidget {
//   const CustomElevatedButton({super.key});
//   TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//                       onPressed: () {
//                         if (controller.isLastPage) {
//                           _onFinish(context);
//                         } else {
//                           controller.pageController.nextPage(
//                             duration: Duration(milliseconds: 500),
//                             curve: Curves.easeOut,
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         fixedSize: Size(MediaQuery.of(context).size.width, 48),
//                       ),
//                       child: Consumer<OnboardingController>(
//                         builder: (context, OnboardingController controller, _) {
//                           return controller.isLastPage
//                               ? Text('Get Started')
//                               : Text('Next');
//                         },
//                       ),
//                     ),;
//   }
// }
