import 'dart:io';

import 'package:testquick/app/domain/entities/user.dart';

class UserModel extends User {
  final File avatarFile;

  UserModel({
    int id,
    String uid,
    String token,
    String firstName,
    String lastName,
    String email,
    String password,
    String avatar,
    bool verifiedEmail,
    this.avatarFile,
  }) : super(
          id: id,
          uid: uid,
          token: token,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          avatar: avatar,
          verifiedEmail: verifiedEmail,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      password: json["password"],
      avatar: json["avatar"],
      verifiedEmail: json["verified_email"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "avatar": avatar,
    };
  }

  UserModel copyWith({
    int id,
    String uid,
    String token,
    String firstName,
    String lastName,
    String email,
    String password,
    bool verifiedEmail,
    String avatar,
    File avatarFile,
  }) =>
      UserModel(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        token: token ?? this.token,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        avatar: avatar ?? this.avatar,
        verifiedEmail: verifiedEmail ?? this.verifiedEmail,
        avatarFile: avatarFile ?? this.avatarFile,
      );
}
