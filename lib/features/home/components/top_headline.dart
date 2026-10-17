import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/widgets/request_status_error.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/components/top_headline_shimmer.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/cubit/home_state.dart';

class TopHeadLine extends StatelessWidget {
  const TopHeadLine({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.topHeadLineStatus) {
          case RequestStatusEnum.initial:
          case RequestStatusEnum.loading:
            return TopHeadlineShimmer();
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(
              child: RequestStatusError(
                errorMessage: state.topHeadLineErrorMessage,
                onPressed: () {
                  context.read<HomeCubit>().getTopHeadLine();
                },
              ),
            );
          case RequestStatusEnum.loaded:
            return SliverList.builder(
              itemCount: state.newsTopHeadLineList.length,
              itemBuilder: (context, index) {
                final model = state.newsTopHeadLineList[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
