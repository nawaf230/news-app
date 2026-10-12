// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeState extends Equatable {
  const HomeState({
    this.newsEverythingList = const [],
    this.newsTopHeadLineList = const [],
    this.everythingStatus = RequestStatusEnum.loading,
    this.topHeadLineStatus = RequestStatusEnum.loading,
    this.everythingErrorMessage,
    this.topHeadLineErrorMessage,
    this.selectedCategory = 'general',
  });

  final List<NewsArticleModel> newsEverythingList;
  final List<NewsArticleModel> newsTopHeadLineList;

  final RequestStatusEnum everythingStatus;
  final RequestStatusEnum topHeadLineStatus;
  final String? everythingErrorMessage;
  final String? topHeadLineErrorMessage;

  final String selectedCategory;

  HomeState copyWith({
    List<NewsArticleModel>? newsEverythingList,
    List<NewsArticleModel>? newsTopHeadLineList,
    RequestStatusEnum? everythingStatus,
    RequestStatusEnum? topHeadLineStatus,
    String? everythingErrorMessage,
    String? topHeadLineErrorMessage,
    String? selectedCategory,
  }) {
    return HomeState(
      newsEverythingList: newsEverythingList ?? this.newsEverythingList,
      newsTopHeadLineList: newsTopHeadLineList ?? this.newsTopHeadLineList,
      everythingStatus: everythingStatus ?? this.everythingStatus,
      topHeadLineStatus: topHeadLineStatus ?? this.topHeadLineStatus,
      everythingErrorMessage: everythingErrorMessage,
      topHeadLineErrorMessage: topHeadLineErrorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props {
    return [
      newsEverythingList,
      newsTopHeadLineList,
      everythingStatus,
      topHeadLineStatus,
      everythingErrorMessage,
      topHeadLineErrorMessage,
      selectedCategory,
    ];
  }
}
