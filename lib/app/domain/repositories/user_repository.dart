import 'package:dartz/dartz.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/data/models/user_model.dart';

abstract class UserRepository {
  // Update user
  Future<Either<Failure, UserModel>> updateUser(UserModel user);

  // Get current user
  Future<Either<Failure, UserModel>> getCurrentUser();
}
