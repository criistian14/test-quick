import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/domain/repositories/theme_repository.dart';

class SetTheme extends UseCase<void, ThemeMode> {
  final ThemeRepository repository;

  SetTheme({
    @required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    return repository.setTheme(themeMode);
  }
}
