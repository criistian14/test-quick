import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/utils/network_info.dart';
import 'package:testquick/app/data/datasources/local/theme_local_data_source.dart';
import 'package:testquick/app/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ThemeRepositoryImpl({
    @required this.localDataSource,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, ThemeMode>> getTheme() async {
    try {
      ThemeMode theme = await localDataSource.getTheme();
      return Right(theme);

      //  Errors
    } on CacheException catch (e) {
      return Left(CacheFailure(
        error: e.error,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> setTheme(ThemeMode themeMode) async {
    try {
      await localDataSource.setTheme(themeMode);
      return Right(null);

      //  Errors
    } on CacheException catch (e) {
      return Left(CacheFailure(
        error: e.error,
      ));
    }
  }
}
