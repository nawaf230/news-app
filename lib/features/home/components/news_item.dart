import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/extensions/date_time_extensions.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});

  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomCachedNetworkImage(imagePath: model.urlToImage ?? ''),
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
                  textAlign: .start,
                ),
                const Gap(12),
                Row(
                  children: [
                    model.urlToImage != null
                        ? CircleAvatar(backgroundImage: NetworkImage(model.urlToImage!), radius: 10)
                        : SizedBox(height: 20, width: 20),
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
                    Expanded(
                      child: Text(
                        model.publishedAt.formatDateTime(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF363636),
                        ),
                      ),
                    ),
                    CustomSvgPicture.withoutColor(path: 'assets/images/bookmark.svg'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
