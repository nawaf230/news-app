import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/home/repos/news_repository.dart';

class HomeController extends ChangeNotifier {
  List<NewsArticleModel> newsEverythingList = [];
  List<NewsArticleModel> newsTopHeadLineList = [];

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadLineStatus = RequestStatusEnum.loading;
  String? everythingErrorMessage;
  String? topHeadLineErrorMessage;

  String selectedCategory = 'general';

  // Here I create Object in
  final NewsRepository newsRepository;

  HomeController(this.newsRepository) {
    getTopHeadLine();
    getEverything();
  }

  void getTopHeadLine({String? categories}) async {
    topHeadLineStatus = RequestStatusEnum.loading;
    notifyListeners();
    try {
      newsTopHeadLineList = await newsRepository.getTopHeadLine(selectedCategory: selectedCategory);
      topHeadLineStatus = RequestStatusEnum.loaded;
    } catch (e) {
      topHeadLineErrorMessage = e.toString();
      topHeadLineStatus = RequestStatusEnum.error;
    }

    notifyListeners();
  }

  void getEverything() async {
    try {
      newsEverythingList = await newsRepository.getEverything(selectedCategory: selectedCategory);
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
