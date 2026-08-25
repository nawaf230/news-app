import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
              const Gap(4),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 8),
                child: SizedBox(
                  height: 35,
                  child: ListView.separated(
                    padding: EdgeInsets.only(right: 16),
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const Gap(12);
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: isSelected! ? LightColors.primaryColor : Color(0xFF363636),
                                ),
                              ),
                              if (isSelected!) ...[
                                const Gap(8),
                                Container(color: LightColors.primaryColor, height: 2),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Gap(8),
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
