import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  List<NewsArticleModel> newsEverythingList = [];
  List<NewsArticleModel> newsTopHeadLineList = [];
  final ApiService apiService = ApiService();
  bool topHeadLineLoading = true;
  bool everythingLoading = true;
  String? errorMessage;

  HomeController() {
    getTopHeadLine();
    getEverything();
  }

  void getTopHeadLine() async {
    try {
      final result = await apiService.get(
        queryParameters: {'country': 'us'},
        ApiConfig.topHeadLines,
      );

      newsTopHeadLineList = (result['articles'] as List)
          .map((e) => NewsArticleModel.formJson(e))
          .toList();

      topHeadLineLoading = false;
    } catch (e) {
      errorMessage = e.toString();
      topHeadLineLoading = false;
      errorMessage = e.toString();
    }

    notifyListeners();
  }

  void getEverything() async {
    try {
      final result = await apiService.get(
        queryParameters: {'q': 'science'},
        ApiConfig.everything,
      );

      newsEverythingList = (result['articles'] as List)
          .map((e) => NewsArticleModel.formJson(e))
          .toList();

      newsEverythingList = (result['articles'] as List)
          .map((e) => NewsArticleModel.formJson(e))
          .toList();
      everythingLoading = false;
    } catch (e) {
      everythingLoading = false;

      errorMessage = e.toString();
    }

    notifyListeners();
  }
}
