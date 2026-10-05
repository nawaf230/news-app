import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/search/search_screen_controller.dart';
import 'package:provider/provider.dart';

import '../details/news_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchScreenController>(
      create: (BuildContext context) => SearchScreenController(NewsRepository(ApiService())),
      child: Scaffold(
        appBar: AppBar(title: Text('Search')),
        body: Consumer<SearchScreenController>(
          builder: (context, controller, child) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSizes.w16),
                  child: TextField(
                    onChanged: (value) {
                      controller.getEverything();
                    },
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: AppSizes.sp14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFA0A0A0),
                      ),
                      suffixIcon: Icon(Icons.search, color: Color(0xFFA0A0A0), size: AppSizes.r30),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.newsEverythingList.length,
                    itemBuilder: (context, index) {
                      final model = controller.newsEverythingList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NewsDetailsScreen(model: model),
                              ),
                            );
                          },
                          title: Text(
                            model.title,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: AppSizes.sp16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6D6D6D),
                            ),
                          ),
                          leading: Icon(Icons.search, color: Color(0xFF6D6D6D), size: AppSizes.r20),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
