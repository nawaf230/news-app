import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/models/user_model.dart';
  
class ProfileController extends ChangeNotifier with SafeNotifyMixin {
  XFile? selectedFile;

  String? userName;
  String? countryName;
  String? countryCode;

  void init() {
    getUserData();
  }

  void pickImage(ImageSource source) async {
    selectedFile = await ImagePicker().pickImage(source: source);

    safeNotify();
  }

  void getUserData() {
    final UserModel? user = UserRepository().getUser();
    userName = user?.name ?? 'User Name';
    countryName = user?.cuntryName ?? '';
    countryCode = user?.cuntryCode ?? '';

    safeNotify();
  }

  void saveCountry(Country country) async {
    await UserRepository().updateUser(cuntryName: country.name, cuntryCode: country.countryCode);

    countryName = country.name;
    countryCode = country.countryCode;

    safeNotify();
  }
}
