import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/routes/app_routes.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/domain/usecases/get_theme.dart';
import 'package:testquick/app/domain/usecases/is_authenticated.dart';

class SplashController extends GetxController {
  final IsAuthenticated _isAuthenticated;
  final GetTheme _getTheme;

  List<Locale> _locales = [
    Locale('en', 'US'),
    Locale('en_US'),
    Locale('es', 'CO'),
    Locale('es_CO'),
  ];

  SplashController({
    @required IsAuthenticated isAuthenticated,
    @required GetTheme getTheme,
  })  : assert(isAuthenticated != null),
        assert(getTheme != null),
        _isAuthenticated = isAuthenticated,
        _getTheme = getTheme;

  @override
  void onInit() async {
    super.onInit();

    final result = await _getTheme.call(NoParams());
    result.fold(Alerts.errorAlertUseCase, (r) {
      Get.changeThemeMode(r);
    });
  }

  @override
  void onReady() async {
    super.onReady();

    String deviceLocaleStr = Platform.localeName;
    Locale deviceLocale = Locale(deviceLocaleStr);
    if (_locales.contains(deviceLocale)) {
      Get.updateLocale(deviceLocale);
    } else {
      Get.updateLocale(Locale("en", "US"));
    }

    await Future.delayed(
      Duration(milliseconds: 800),
    );

    var isAuthenticatedCall = await _isAuthenticated.call(NoParams());
    isAuthenticatedCall.fold(Alerts.errorAlertUseCase, (r) {
      if (r) {
        Get.offNamedUntil(AppRoutes.HOME, (route) => false);

        // ! Not Authenticated
      } else {
        Get.offNamedUntil(AppRoutes.SIGN_IN, (route) => false);
      }
    });
  }
}
