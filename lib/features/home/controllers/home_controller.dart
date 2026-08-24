import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  List<NewsArticleModel> newsEverythingList = [];
  List<NewsArticleModel> newsTopHeadLineList = [];
  final ApiService apiService = ApiService();

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadLineStatus = RequestStatusEnum.loading;
  String? everythingErrorMessage;
  String? topHeadLineErrorMessage;

  String selectedCategory = 'general';

  HomeController() {
    getTopHeadLine();
    getEverything();
  }

  void getTopHeadLine({String? categories}) async {
    topHeadLineStatus = RequestStatusEnum.loading;
    notifyListeners();
    try {
      final result = await apiService.get(
        params: {'country': 'us', 'category': selectedCategory},
        ApiConfig.topHeadLines,
      );

      newsTopHeadLineList = (result['articles'] as List)
          .map((e) => NewsArticleModel.formJson(e))
          .toList();

      topHeadLineStatus = RequestStatusEnum.loaded;
    } catch (e) {
      topHeadLineErrorMessage = e.toString();
      topHeadLineStatus = RequestStatusEnum.error;
    }

    notifyListeners();
  }

  void getEverything() async {
    try {
      final Map<String, dynamic> result = await apiService.get(
        ApiConfig.everything,
        params: {'q': 'science', 'language': 'en'},
      );

      newsEverythingList = (result['articles'] as List).reversed
          .map((e) => NewsArticleModel.formJson(e))
          .toList();
      everythingStatus = RequestStatusEnum.loaded;
    } catch (e) {
      everythingErrorMessage = e.toString();
      everythingStatus = RequestStatusEnum.error;
    }

    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(categories: selectedCategory);

    notifyListeners();
  }
}
