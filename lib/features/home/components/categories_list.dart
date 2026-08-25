import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
