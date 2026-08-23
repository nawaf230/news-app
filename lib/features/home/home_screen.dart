import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/trending_news.dart';
import 'package:news_app/features/home/components/view_all_components.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, HomeController controller, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                TrendingNews(),
                SliverToBoxAdapter(
                  child: ViewAllComponents(
                    title: 'Categories',
                    titleColor: Color(0xFF141414),
                    onTap: () {},
                  ),
                ),
                CategoriesList(),
                SliverList.builder(
                  itemCount: controller.newsTopHeadLineList.length,
                  itemBuilder: (context, index) {
                    final model = controller.newsTopHeadLineList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              model.urlToImage ?? "https://static.vecteezy.com/system/resources/thumbnails/057/068/323/small/single-fresh-red-strawberry-on-table-green-background-food-fruit-sweet-macro-juicy-plant-image-photo.jpg",
                              height: 80,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF141414),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Gap(4),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(model.urlToImage),
                                      radius: 10,
                                    ),
                                    const Gap(4),
                                    SizedBox(
                                      width: 70,
                                      height: 20,
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        model.author,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF141414),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Gap(4),
                                    Text(
                                      model.formatDateTime(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF363636),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
