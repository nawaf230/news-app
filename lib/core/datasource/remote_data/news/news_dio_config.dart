import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/remote_data/Interceptors/api_key_interceptor.dart';
import 'package:news_app/core/datasource/remote_data/Interceptors/logging_interceptor.dart';
import 'package:news_app/core/datasource/remote_data/news/news_api_config.dart';

class NewsDioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: NewsApiConfig.newsBaseUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
      ),
    );

    dio.interceptors.addAll([ApiKeyInterceptor(), LoggingInterceptor()]);

    return dio;
  }
}
