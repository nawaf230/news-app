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

import 'components/categories_list.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
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
                    onRefresh: () => controller.getTopHeadLine(),
                    displacement: 20,
                    color: LightColors.primaryColor,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: constraints.maxHeight * 0.9,
                        child: RequestStatusError(onPressed: () => controller.getTopHeadLine()),
                      ),
                    ),
                  );
                },
              );

            case RequestStatusEnum.loaded:
              bool? isSelected;

              return Column(
                children: [
                  SizedBox(height: AppSizes.h4),
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppSizes.w16,
                      top: AppSizes.h16,
                      bottom: AppSizes.w8,
                    ),
                    child: SizedBox(
                      height: AppSizes.h35,
                      child: ListView.separated(
                        padding: EdgeInsets.only(right: AppSizes.w16),
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: AppSizes.w12);
                        },
                        itemBuilder: (context, index) {
                          isSelected = state.selectedCategory == categories[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<HomeCubit>().updateSelectedCategory(categories[index]);
                            },
                            child: IntrinsicWidth(
                              child: Column(
                                children: [
                                  Text(
                                    categories[index][0].toUpperCase() +
                                        categories[index].substring(1),
                                    style: TextStyle(
                                      fontSize: AppSizes.sp16,
                                      fontWeight: FontWeight.w400,
                                      color: isSelected!
                                          ? LightColors.primaryColor
                                          : Color(0xFF363636),
                                      fontFamily: 'times',
                                    ),
                                  ),
                                  if (isSelected!) ...[
                                    SizedBox(height: AppSizes.w8),
                                    Container(color: LightColors.primaryColor, height: AppSizes.h2),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.h8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.newsTopHeadLineList.length,
                      itemBuilder: (context, index) {
                        final model = state.newsTopHeadLineList[index];

                        return NewsItem(model: model);
                      },
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
