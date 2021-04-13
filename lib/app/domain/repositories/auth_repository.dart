import 'package:dartz/dartz.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/data/models/user_model.dart';

abstract class AuthRepository {
  // Sign in with email and password user
  Future<Either<Failure, UserModel>> signInWithEmail(UserModel user);

  // Check if it is authenticated
  Future<Either<Failure, bool>> checkIsAuthenticated();

  // Sign Out
  Future<Either<Failure, void>> signOut();
}
