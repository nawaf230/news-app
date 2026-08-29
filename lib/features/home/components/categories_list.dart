import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/components/view_all_components.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeController>(
        builder: (context, controller, _) {
          bool? isSelected;
          return Column(
            children: [
              ViewAllComponents(
                title: 'Categories',
                titleColor: Color(0xFF141414),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider.value(
                        value: Provider.of<HomeController>(context, listen: false),
                        child: CategoriesScreen(),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppSizes.w16,
                  top: AppSizes.h16,
                  bottom: AppSizes.h16,
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
                                SizedBox(height: AppSizes.h8),
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
            ],
          );
        },
      ),
    );
  }
}

final List<String> categories = [
  'general',
  'business',
  'technology',
  'sports',
  'entertainment',
  'health',
  'science',
];
