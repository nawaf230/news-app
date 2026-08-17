import 'package:flutter/material.dart';
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
                    child: Text(
                      controller.errorMessage.toString(),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 30,
                          ),
                          child: ListView.builder(
                            itemCount: controller.newsTopHeadLineList.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    controller
                                        .newsTopHeadLineList[index]
                                        .description,
                                  ),
                                ),
                          ),
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
