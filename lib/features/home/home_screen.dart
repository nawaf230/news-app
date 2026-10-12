import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/top_headline.dart';
import 'package:news_app/features/home/components/trending_news.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// Here I inject NewsRepository and ApiService as a objects.
      create: (context) => HomeCubit(NewsRepository(ApiService())),
      child: Scaffold(
        body: CustomScrollView(slivers: [TrendingNews(), CategoriesList(), TopHeadLine()]),
      ),
    );
  }
}
