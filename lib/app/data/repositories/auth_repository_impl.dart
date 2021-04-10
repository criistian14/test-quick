import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/utils/network_info.dart';
import 'package:testquick/app/data/datasources/remote/auth_remote_data_source.dart';
import 'package:testquick/app/domain/entities/user.dart';
import 'package:testquick/app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    @required this.remoteDataSource,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> signInWithEmail(User user) async {
    try {
      final foundUser = await remoteDataSource.signInWithEmail(user);

      return Right(foundUser);
    } on ApiException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIsAuthenticated() async {
    try {
      final isAuth = await remoteDataSource.checkIsAuthenticated();

      return Right(isAuth);
    } on ApiException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();

      return Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
      ));
    }
  }
}
