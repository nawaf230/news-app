import 'package:dio/dio.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_dio_config.dart';

abstract class AuthBaseApiService {
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? bady});
}

class AuthApiService extends AuthBaseApiService {
  final dio = AuthDioConfig.createDio();

  @override
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? bady}) async {
    try {
      // Here I sent the Request and I wait xthe Response.
      final response = await dio.post(endpoint, data: bady);

      final responseBody = response.data as Map<String, dynamic>;
      print('=======$responseBody');

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(responseBody["message"] ?? 'Failed To load Data');
      }
    } on DioException catch (e) {
      _handleDioExceptionException(e);
    }
  }

  void _handleDioExceptionException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw Exception('Connection timeout - Please check your internet');
      case DioExceptionType.sendTimeout:
        throw Exception('Send timeout - Please try again');
      case DioExceptionType.receiveTimeout:
        throw Exception('Receive timeout - Server took too long to respond');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Failed to load news';
        throw Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        throw Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        throw Exception('No internet connection');
      default:
        throw Exception('Failed to load news');
    }
  }
}
