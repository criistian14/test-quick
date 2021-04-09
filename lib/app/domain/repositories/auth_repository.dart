import 'package:dartz/dartz.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/domain/entities/user.dart';

abstract class AuthRepository {
  // Sign in with email and password user
  Future<Either<Failure, User>> signInWithEmail(User user);

  // Check if it is authenticated
  Future<Either<Failure, bool>> checkIsAuthenticated();

  // Sign Out
  Future<Either<Failure, void>> signOut();
}
