import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: controller.topHeadLineLoading
                ? Center(child: CircularProgressIndicator())
                : controller.errorMessage != null
                ? Center(
                    child: Text(controller.errorMessage.toString(), textAlign: TextAlign.center),
                  )
                : Stack(
                    children: [
                      SizedBox(
                        height: 240,
                        width: double.infinity,
                        child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
                      ),
                      Positioned.fill(
                        top: 65,
                        child: Column(
                          children: [
                            Text(
                              'NEWST',
                              style: TextStyle(fontSize: 40, color: LightColors.primaryColor),
                            ),
                            const Gap(16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Trending News',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFFFCFC),
                                    ),
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFFFFCFC),
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xFFFFFCFC),
                                      decorationThickness: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(itemBuilder: (context, index) {}),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
