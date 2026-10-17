import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/remote_data/Interceptors/auth_interceptor.dart';
import 'package:news_app/core/datasource/remote_data/Interceptors/logging_interceptor.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_config.dart';

class AuthDioConfig {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AuthApiConfig.authBaseUrl,
        headers: {"Content-Type": "application/json"},
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
      ),
    );

    dio.interceptors.addAll([LoggingInterceptor(), AuthInterceptor()]);

    return dio;
  }
}
