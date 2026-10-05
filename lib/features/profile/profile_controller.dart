import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';

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
    userName = PreferencesManager().getString(StorageKey.userName);
    countryName = PreferencesManager().getString(StorageKey.countryName);
    countryCode = PreferencesManager().getString(StorageKey.countryCode);

    safeNotify();
  }

  void saveCountry(Country country) async {
    await PreferencesManager().setString(StorageKey.countryName, country.name);
    await PreferencesManager().setString(StorageKey.countryCode, country.countryCode);
    countryName = country.name;
    countryCode = country.countryCode;

    safeNotify();
  }
}
