import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

import 'components/categories_list.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
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
                      isSelected = controller.selectedCategory == categories[index];
                      return GestureDetector(
                        onTap: () {
                          controller.updateSelectedCategory(categories[index]);
                        },
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Text(
                                categories[index][0].toUpperCase() + categories[index].substring(1),
                                style: TextStyle(
                                  fontSize: AppSizes.sp16,
                                  fontWeight: FontWeight.w400,
                                  color: isSelected! ? LightColors.primaryColor : Color(0xFF363636),
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
                  itemCount: controller.newsTopHeadLineList.length,
                  itemBuilder: (context, index) {
                    final model = controller.newsTopHeadLineList[index];

                    return NewsItem(model: model);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
