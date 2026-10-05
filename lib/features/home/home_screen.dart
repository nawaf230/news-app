import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/top_headline.dart';
import 'package:news_app/features/home/components/trending_news.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      /// Here I inject NewsRepository and ApiService as a objects.
      create: (context) => HomeController(NewsRepository(ApiService())),
      child: Scaffold(
        body: CustomScrollView(slivers: [TrendingNews(), CategoriesList(), TopHeadLine()]),
      ),
    );
  }
}
