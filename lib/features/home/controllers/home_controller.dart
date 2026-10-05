import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeController extends ChangeNotifier with SafeNotifyMixin {
  List<NewsArticleModel> newsEverythingList = [];
  List<NewsArticleModel> newsTopHeadLineList = [];

  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadLineStatus = RequestStatusEnum.loading;
  String? everythingErrorMessage;
  String? topHeadLineErrorMessage;

  String selectedCategory = 'general';

  // Here I create Object in
  final BaseNewsRepository newsRepository;

  HomeController(this.newsRepository) {
    getTopHeadLine();
    getEverything();
  }

  void getTopHeadLine({String? categories}) async {
    topHeadLineStatus = RequestStatusEnum.loading;
    safeNotify();
    try {
      newsTopHeadLineList = await newsRepository.getTopHeadLine(selectedCategory: selectedCategory);
      topHeadLineStatus = RequestStatusEnum.loaded;
    } catch (e) {
      topHeadLineErrorMessage = e.toString();
      topHeadLineStatus = RequestStatusEnum.error;
    }

    safeNotify();
  }

  void getEverything() async {
    try {
      newsEverythingList = await newsRepository.getEverything();
      everythingStatus = RequestStatusEnum.loaded;
    } catch (e) {
      everythingErrorMessage = e.toString();
      everythingStatus = RequestStatusEnum.error;
    }

    safeNotify();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(categories: selectedCategory);

    safeNotify();
  }
}
