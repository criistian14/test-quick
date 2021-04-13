import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/utils/network_info.dart';
import 'package:testquick/app/data/datasources/remote/user_remote_data_source.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    @required this.remoteDataSource,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, UserModel>> updateUser(UserModel user) async {
    try {
      final updatedUser = await remoteDataSource.updateUser(user);

      return Right(updatedUser);
    } on ApiException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
      ));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final foundUser = await remoteDataSource.getCurrentUser();

      return Right(foundUser);
    } on ApiException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
      ));
    }
  }
}
