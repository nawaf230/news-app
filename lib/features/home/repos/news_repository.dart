import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsRepository {
  Future<List<NewsArticleModel>> getTopHeadLine({String selectedCategory = 'general'}) async {
    final Map<String, dynamic> result = await ApiService().get(
      params: {'country': 'us', 'category': selectedCategory},
      ApiConfig.topHeadLines,
    );

    return (result['articles'] as List).map((e) => NewsArticleModel.formJson(e)).toList();
  }

  Future<List<NewsArticleModel>> getEverything({String selectedCategory = 'general'}) async {
    final Map<String, dynamic> result = await ApiService().get(
      ApiConfig.everything,
      params: {'q': 'science', 'language': 'en'},
    );

    return (result['articles'] as List).reversed.map((e) => NewsArticleModel.formJson(e)).toList();
  }
}

class NewsRepositoryMock {
  Future<List<NewsArticleModel>> getTopHeadLine({String selectedCategory = 'general'}) async {
    final Map<String, dynamic> result = await ApiService().get(
      params: {'country': 'us', 'category': selectedCategory},
      ApiConfig.topHeadLines,
    );

    return (result['articles'] as List).map((e) => NewsArticleModel.formJson(e)).toList();
  }

  Future<List<NewsArticleModel>> getEverything({String selectedCategory = 'general'}) async {
    final Map<String, dynamic> result = await ApiService().get(
      ApiConfig.everything,
      params: {'q': 'science', 'language': 'en'},
    );

    return (result['articles'] as List).reversed.map((e) => NewsArticleModel.formJson(e)).toList();
  }
}
