import 'package:dartz/dartz.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/domain/entities/user.dart';

abstract class AuthRepository {
  // Sign in with email and password user
  Future<Either<Failure, User>> signInWithEmail(User user);
}
