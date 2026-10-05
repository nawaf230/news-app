import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/extensions/date_time_extensions.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.model});

  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
          child: Column(
            children: [
              SizedBox(height: AppSizes.h20),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: CustomCachedNetworkImage(
                    imagePath: model.urlToImage.toString(),
                    height: AppSizes.h228,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: AppSizes.h12),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF141414),
                ),
              ),
              SizedBox(height: AppSizes.h8),
              Row(
                children: [
                  model.urlToImage != null
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFD3D3D3), width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(model.urlToImage!),
                            radius: 16,
                          ),
                        )
                      : SizedBox(height: AppSizes.h20, width: AppSizes.w20),
                  SizedBox(width: AppSizes.w6),
                  SizedBox(
                    width: AppSizes.w85,
                    height: AppSizes.h20,
                    child: Text(
                      textAlign: TextAlign.start,
                      model.author,
                      style: TextStyle(
                        fontSize: AppSizes.sp14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF141414),
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
                      ),
                    ),
                  ),
                  CustomSvgPicture.withoutColor(
                    path: 'assets/images/bookmark.svg',
                    height: AppSizes.h20,
                    width: AppSizes.w20,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.h12),
              Text(
                textAlign: TextAlign.start,
                model.description,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF363636),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
