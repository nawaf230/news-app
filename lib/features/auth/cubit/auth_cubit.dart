import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/core/repos/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState());

  AuthRepository authRepository;

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    try {
      emit(
        state.copyWith(status: RequestStatusEnum.loading, errorMessage: null),
      );

      final userModel = await authRepository.login(
        userName: userName,
        password: password,
      );

      await PreferencesManager().setBool(StorageKey.isLoggedIn, true);

      emit(
        state.copyWith(status: RequestStatusEnum.loaded, userModel: userModel),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatusEnum.error,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RequestStatusEnum.loading, errorMessage: null));

    // This code means wait 2s.
    await Future.delayed(Duration(seconds: 2));

    final error = await UserRepository().singUp(
      name: name,
      email: email,
      password: password,
    );

    if (error != null) {
      emit(
        state.copyWith(
          status: RequestStatusEnum.error,
          errorMessage: error.replaceFirst('Exception: ', ''),
        ),
      );
    } else {
      await PreferencesManager().setBool(StorageKey.isLoggedIn, true);
      emit(state.copyWith(status: RequestStatusEnum.loaded));
    }
  }
}
