import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/routes/app_routes.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/core/utils/modals.dart';
import 'package:testquick/app/domain/usecases/set_theme.dart';
import 'package:testquick/app/domain/usecases/sign_out.dart';

class SettingsController extends GetxController {
  final SignOut _signOut;
  final SetTheme _setTheme;

  SettingsController({
    @required SignOut signOut,
    @required SetTheme setTheme,
  })  : assert(signOut != null),
        assert(setTheme != null),
        _signOut = signOut,
        _setTheme = setTheme;

  void signOut() async {
    var signOutCall = await _signOut.call(NoParams());
    signOutCall.fold(Alerts.errorAlertUseCase, (r) {
      Get.offNamedUntil(AppRoutes.SIGN_IN, (route) => false);
    });
  }

  void goEditProfile() {
    Get.toNamed(AppRoutes.EDIT_PROFILE);
  }

  void changeTheme() async {
    Either<Failure, void> result;

    if (Get.isDarkMode) {
      result = await _setTheme.call(ThemeMode.light);
    } else {
      result = await _setTheme.call(ThemeMode.dark);
    }

    result.fold(Alerts.errorAlertUseCase, (_) => null);
  }

  void changeLanguage() async {
    Locale locale = await ModalsUtils.pickLanguage();
    if (locale == null) return;

    Get.updateLocale(locale);
  }
}
