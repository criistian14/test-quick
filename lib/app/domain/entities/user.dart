import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String uid, token, firstName, lastName, email, password;
  final bool verifiedEmail;

  User({
    this.id,
    this.uid,
    this.token,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.verifiedEmail,
  });

  @override
  List<Object> get props => [
        id,
        uid,
        token,
        firstName,
        lastName,
        email,
        password,
        verifiedEmail,
      ];
}
