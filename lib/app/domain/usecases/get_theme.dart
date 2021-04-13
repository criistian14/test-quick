import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/domain/repositories/theme_repository.dart';

class GetTheme extends UseCase<ThemeMode, NoParams> {
  final ThemeRepository repository;

  GetTheme({
    @required this.repository,
  });

  @override
  Future<Either<Failure, ThemeMode>> call(NoParams _) {
    return repository.getTheme();
  }
}
