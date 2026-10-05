import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsArticleModel>> getTopHeadLine({String selectedCategory = 'general'});

  Future<List<NewsArticleModel>> getEverything({String selectedCategory = 'general'});
}

class NewsRepository extends BaseNewsRepository {
  final BaseApiService apiService;

  NewsRepository(this.apiService);

  @override
  Future<List<NewsArticleModel>> getTopHeadLine({String selectedCategory = 'general'}) async {
    final Map<String, dynamic> result = await apiService.get(
      params: {'country': 'us', 'category': selectedCategory},
      ApiConfig.topHeadLines,
    );

    return (result['articles'] as List).map((e) => NewsArticleModel.formJson(e)).toList();
  }

  @override
  Future<List<NewsArticleModel>> getEverything({String selectedCategory = 'general'}) async {
    final Map<String, dynamic> result = await apiService.get(
      ApiConfig.everything,
      params: {'q': 'science', 'language': 'en'},
    );

    return (result['articles'] as List).reversed.map((e) => NewsArticleModel.formJson(e)).toList();
  }
}
