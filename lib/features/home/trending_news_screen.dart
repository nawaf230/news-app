import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/request_status_error.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/cubit/home_state.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsScreen extends StatelessWidget {
  const TrendingNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trending News')),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final controller = context.read<HomeCubit>();

          switch (state.topHeadLineStatus) {
            case RequestStatusEnum.initial:
            case RequestStatusEnum.loading:
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.w16, vertical: AppSizes.h8),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(height: AppSizes.h80, color: Colors.white),
                    ),
                  );
                },
              );
            case RequestStatusEnum.error:
              return LayoutBuilder(
                builder: (context, constraints) {
                  return RefreshIndicator(
                    onRefresh: () => controller.getEverything(),
                    displacement: 20,
                    color: LightColors.primaryColor,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: constraints.maxHeight * 0.9,
                        child: RequestStatusError(
                          onPressed: () => controller.getEverything(),
                          errorMessage: state.topHeadLineErrorMessage,
                        ),
                      ),
                    ),
                  );
                },
              );
            case RequestStatusEnum.loaded:
              return RefreshIndicator(
                onRefresh: () => context.read<HomeCubit>().getEverything(),
                displacement: 20,
                color: LightColors.primaryColor,
                child: ListView.builder(
                  itemCount: state.newsEverythingList.length,
                  itemBuilder: (context, index) {
                    final model = state.newsEverythingList[index];

                    return NewsItem(model: model);
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
