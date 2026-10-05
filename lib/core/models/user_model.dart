import 'package:hive_ce_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? password;

  @HiveField(3)
  String? cuntryName;

  @HiveField(4)
  String? cuntryCode;

  UserModel({
    required this.name,
    required this.email,
    this.password,
    this.cuntryName,
    this.cuntryCode,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'password': password, 'cuntryName': cuntryName};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      cuntryName: map['cuntryName'] as String,
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? cuntryName,
    String? cuntryCode,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      cuntryName: cuntryName ?? this.cuntryName,
      cuntryCode: cuntryCode ?? this.cuntryCode,
    );
  }
}
