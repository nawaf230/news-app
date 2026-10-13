import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/extensions/date_time_extensions.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/bookmark_button.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/details/news_details_screen.dart';
import 'package:news_app/features/home/components/trending_news_shimmer.dart';
import 'package:news_app/features/home/components/view_all_components.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/cubit/home_state.dart';
import 'package:news_app/features/home/trending_news_screen.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h325,
        child: Stack(
          children: [
            SizedBox(
              height: AppSizes.h240,
              width: double.infinity,
              child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
            ),
            Positioned.fill(
              top: AppSizes.h65,
              child: Column(
                children: [
                  Text(
                    'NEWST',
                    style: TextStyle(fontSize: AppSizes.sp40, color: LightColors.primaryColor),
                  ),
                  SizedBox(height: AppSizes.h6),
                  ViewAllComponents(
                    title: 'Trending News',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return BlocProvider.value(
                              value: context.read<HomeCubit>(),
                              child: TrendingNewsScreen(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppSizes.h12),
                  SizedBox(
                    height: AppSizes.h140,
                    width: double.infinity,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        switch (state.everythingStatus) {
                          case RequestStatusEnum.loading:
                            return TrendingNewsShimmer();
                          case RequestStatusEnum.error:
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                                  SizedBox(height: AppSizes.h16),

                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<HomeCubit>().getEverything();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          case RequestStatusEnum.loaded:
                            return ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
                              separatorBuilder: (context, index) => SizedBox(width: AppSizes.w12),
                              itemCount: state.newsEverythingList.take(8).length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final model = state.newsEverythingList[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => NewsDetailsScreen(model: model),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: AppSizes.w240,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Stack(
                                        children: [
                                          if (state.newsEverythingList[index].urlToImage != null)
                                            CustomCachedNetworkImage(
                                              imagePath: model.urlToImage!,
                                              width: AppSizes.w240,
                                              height: AppSizes.h140,
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
                                            top: AppSizes.h8,
                                            right: AppSizes.w8,
                                            child: BookmarkButton(article: model, size: 24),
                                          ),
                                          Positioned(
                                            bottom: AppSizes.h12,
                                            right: AppSizes.w12,
                                            left: AppSizes.w12,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.title,
                                                  style: TextStyle(
                                                    fontSize: AppSizes.sp14,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFFFFFCFC),
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: AppSizes.h4),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: AppSizes.r10,
                                                            backgroundImage: NetworkImage(
                                                              model.urlToImage.toString(),
                                                            ),
                                                          ),
                                                          SizedBox(width: AppSizes.w5),
                                                          Expanded(
                                                            child: Text(
                                                              model.author,
                                                              style: TextStyle(
                                                                fontSize: AppSizes.sp12,
                                                                fontWeight: FontWeight.w400,
                                                                color: Color(0xFFFFFCFC),
                                                              ),
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: AppSizes.w8),
                                                    Text(
                                                      model.publishedAt.formatDateTime(),
                                                      style: TextStyle(
                                                        fontSize: AppSizes.sp14,
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
