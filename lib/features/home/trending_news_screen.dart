import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/cubit/home_state.dart';

class TrendingNewsScreen extends StatelessWidget {
  const TrendingNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trending News')),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.newsEverythingList.length,
            itemBuilder: (context, index) {
              final model = state.newsEverythingList[index];

              return NewsItem(model: model);
            },
          );
        },
      ),
    );
  }
}
