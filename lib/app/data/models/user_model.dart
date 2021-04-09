import 'package:testquick/app/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    int id,
    String uid,
    String token,
    String firstName,
    String lastName,
    String email,
    String password,
    bool verifiedEmail,
  }) : super(
          id: id,
          uid: uid,
          token: token,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          verifiedEmail: verifiedEmail,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      uid: json["uid"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      password: json["password"],
      verifiedEmail: json["verified_email"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "verifiedEmail": verifiedEmail,
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
    bool verified,
    bool receiveMarketingEmail,
  }) =>
      UserModel(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        token: token ?? this.token,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        verifiedEmail: verifiedEmail ?? this.verifiedEmail,
      );
}
