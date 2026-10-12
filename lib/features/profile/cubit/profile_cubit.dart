import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    getUserData();
  }

  Future<void> pickImage(ImageSource source) async {
    emit(state.copyWith(selectedFile: await ImagePicker().pickImage(source: source)));
  }

  void getUserData() {
    final UserModel? user = UserRepository().getUser();

    emit(
      state.copyWith(
        userName: user?.name ?? 'User Name',
        countryName: user?.cuntryName,
        countryCode: user?.cuntryCode,
      ),
    );
  }

  Future<void> saveCountry(Country country) async {
    await UserRepository().updateUser(cuntryName: country.name, cuntryCode: country.countryCode);

    emit(state.copyWith(countryName: country.name, countryCode: country.countryCode));
  }
}
