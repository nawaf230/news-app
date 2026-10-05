import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class SearchController extends ChangeNotifier with SafeNotifyMixin {
  final BaseNewsRepository newsRepository;
  List<NewsArticleModel> newsEverythingList = [];
  RequestStatusEnum everythingStatus = RequestStatusEnum.loading;
  String? everythingErrorMessage;

  SearchController(this.newsRepository);

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
}
