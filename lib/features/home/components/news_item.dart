import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/extensions/date_time_extensions.dart';
import 'package:news_app/core/widgets/bookmark_button.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/details/news_details_screen.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});

  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewsDetailsScreen(model: model)));
      },
      child: Padding(
        padding: EdgeInsets.only(right: AppSizes.w16, left: AppSizes.w16, bottom: AppSizes.h16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r8),
              child: CustomCachedNetworkImage(imagePath: model.urlToImage ?? ''),
            ),
            SizedBox(width: AppSizes.h8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: TextStyle(
                      fontSize: AppSizes.sp16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF141414),
                      fontFamily: 'times',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: .start,
                  ),
                  SizedBox(height: AppSizes.h8),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFD3D3D3), width: 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: AppSizes.r10,
                          child: ClipOval(
                            child: Image.network(
                              'https://www.google.com/s2/favicons?domain=${Uri.tryParse(model.url)?.host ?? ''}&sz=64',
                              width: AppSizes.w20,
                              height: AppSizes.w20,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.public, size: 14, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSizes.w4),
                      SizedBox(
                        width: AppSizes.w70,
                        height: AppSizes.h20,
                        child: Text(
                          textAlign: TextAlign.start,
                          model.author,
                          style: TextStyle(
                            fontSize: AppSizes.sp12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF141414),
                            fontFamily: 'times',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: AppSizes.w4),
                      Expanded(
                        child: Text(
                          model.publishedAt.formatDateTime(),
                          style: TextStyle(
                            fontSize: AppSizes.sp12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF363636),
                            fontFamily: 'times',
                          ),
                        ),
                      ),
                      BookmarkButton(article: model, size: 20),
                    ],
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
