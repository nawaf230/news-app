import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/components/top_headline_shimmer.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadLine extends StatelessWidget {
  const TopHeadLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, HomeController controller, _) {
        switch (controller.topHeadLineStatus) {
          case RequestStatusEnum.loading:
            return TopHeadlineShimmer();
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  controller.topHeadLineErrorMessage.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: AppSizes.sp15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          case RequestStatusEnum.loaded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadLineList.length,
              itemBuilder: (context, index) {
                final model = controller.newsTopHeadLineList[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
