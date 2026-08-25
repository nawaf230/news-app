import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/extensions/date_time_extensions.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/components/trending_news_shimmer.dart';
import 'package:news_app/features/home/components/view_all_components.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:news_app/features/home/trending_news_screen.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 325,
        child: Stack(
          children: [
            SizedBox(
              height: 240,
              width: double.infinity,
              child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
            ),
            Positioned.fill(
              top: 65,
              child: Column(
                children: [
                  Text('NEWST', style: TextStyle(fontSize: 40, color: LightColors.primaryColor)),
                  const Gap(6),
                  ViewAllComponents(
                    title: 'Trending News',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return ChangeNotifierProvider.value(
                              value: context.read<HomeController>(),
                              child: TrendingNewsScreen(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const Gap(12),
                  SizedBox(
                    height: 140,
                    width: double.infinity,
                    child: Consumer<HomeController>(
                      builder: (context, controller, child) {
                        switch (controller.everythingStatus) {
                          case RequestStatusEnum.loading:
                            return TrendingNewsShimmer();
                          case RequestStatusEnum.error:
                            return Center(
                              child: Text(
                                controller.everythingErrorMessage.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          case RequestStatusEnum.loaded:
                            return ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              separatorBuilder: (context, index) => const Gap(12),
                              itemCount: controller.newsEverythingList.take(8).length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final model = controller.newsEverythingList[index];

                                return SizedBox(
                                  width: 240,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      children: [
                                        if (controller.newsEverythingList[index].urlToImage != null)
                                          CustomCachedNetworkImage(
                                            imagePath: model.urlToImage!,
                                            width: 240,
                                            height: 140,
                                          ),
                                        // Image.network(
                                        //   width: 240,
                                        //   height: 140,
                                        //   fit: BoxFit.cover,
                                        //   module.urlToImage!,
                                        // ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,

                                                colors: [
                                                  Colors.black.withValues(alpha: 0.5),
                                                  Colors.black.withValues(alpha: 0.7),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 12,
                                          right: 12,
                                          left: 12,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.title,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFFFFFCFC),
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Gap(4),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 10,
                                                          backgroundImage: NetworkImage(
                                                            model.urlToImage.toString(),
                                                          ),
                                                        ),
                                                        const Gap(5),
                                                        Expanded(
                                                          child: Text(
                                                            model.author,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400,
                                                              color: Color(0xFFFFFCFC),
                                                            ),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Gap(8),
                                                  Text(
                                                    model.publishedAt.formatDateTime(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xFFFFFCFC),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
