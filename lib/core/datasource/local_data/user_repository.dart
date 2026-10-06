// Single Ton class
import 'package:hive_ce_flutter/adapters.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/core/models/user_model.dart';

class UserRepository {
  // Here I store the information the user
  static final UserRepository _instance = UserRepository._internal();

  UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  Box<UserModel>? _userBox;

  Future<void> init() async {
    _userBox = await Hive.openBox(StorageKey.userBox);
  }

  Future<void> saveUser(UserModel user) async {
    await _userBox?.put(StorageKey.currentUser, user);
  }

  UserModel? getUser() => userBox.get(StorageKey.currentUser);

  Box<UserModel> get userBox {
    if (_userBox == null) {
      throw Exception('UserRepository not initialized');
    }
    return _userBox!;
  }

  Future<void> updateUser({
    String? name,
    String? email,
    String? password,
    String? cuntryName,
    String? cuntryCode,
  }) async {
    final user = getUser();
    if (user != null) {
      final updateUser = user.copyWith(
        name: name,
        email: email,
        password: password,
        cuntryName: cuntryName,
        cuntryCode: cuntryCode,
      );
      await saveUser(updateUser);
    }
  }

  Future<void> delete() async {
    await userBox.delete('user');
  }

  Future<void> clearAll() async {
    await userBox.clear();
  }

  String? login(String email, String password) {
    final user = getUser();

    if (user == null) {
      return 'No account Found Please Register First.';
    }

    if (user.email != email || user.password != password) {
      return 'Incorrect Email or Password';
    }
    return null;
  }

  Future<String?> singUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = getUser();

    if (user != null) {
      return 'User Already Exists Please Login.';
    }

    final newUser = UserModel(name: name, email: email, password: password);
    await saveUser(newUser);

    return null;
  }
}
