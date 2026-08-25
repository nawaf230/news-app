import 'package:flutter/material.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNewsScreen extends StatelessWidget {
  const TrendingNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trending News')),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          return ListView.builder(
            itemCount: controller.newsEverythingList.length,
            itemBuilder: (context, index) {
              final model = controller.newsEverythingList[index];

              return NewsItem(model: model);
            },
          );
        },
      ),
    );
  }
}
