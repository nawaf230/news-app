import 'package:news_app/core/datasource/remote_data/news/news_api_config.dart';
import 'package:news_app/core/datasource/remote_data/news/news_api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsArticleModel>> getTopHeadLine({String selectedCategory = 'general'});

  Future<List<NewsArticleModel>> getEverything({String query = 'news'});
}

class NewsRepository extends BaseNewsRepository {
  final BaseNewsApiService apiService;

  NewsRepository(this.apiService);

  @override
  Future<List<NewsArticleModel>> getTopHeadLine({String selectedCategory = 'general'}) async {
    final Map<String, dynamic> result = await apiService.get(
      NewsApiConfig.topHeadLines,
      params: {'country': 'us', 'category': selectedCategory},
    );

    return (result['articles'] as List).map((e) => NewsArticleModel.formJson(e)).toList();
  }

  @override
  Future<List<NewsArticleModel>> getEverything({String query = 'news'}) async {
    final Map<String, dynamic> result = await apiService.get(
      NewsApiConfig.everything,
      params: {'language': 'en', 'q': query},
    );

    return (result['articles'] as List).reversed.map((e) => NewsArticleModel.formJson(e)).toList();
  }
}
