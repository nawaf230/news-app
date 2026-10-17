import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_config.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_service.dart';
import 'package:news_app/core/models/user_model.dart';

class AuthRepository {
  AuthRepository(this.authApiService);

  final AuthBaseApiService authApiService;

  Future<UserModel> login({required String userName, required String password}) async {
    final response = await AuthApiService().post(
      AuthApiConfig.login,
      bady: {"username": userName, "password": password, "expiresInMins": 30},
    );

    final userModel = UserModel.fromAuthResponse(response);
    await _saveUser(userModel);

    return userModel;
  }

  Future<void> _saveUser(UserModel model) async {
    UserRepository().saveUser(model);
  }
}
