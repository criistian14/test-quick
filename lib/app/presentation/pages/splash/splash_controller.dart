import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/routes/app_routes.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/domain/usecases/is_authenticated.dart';

class SplashController extends GetxController {
  final IsAuthenticated _isAuthenticated;

  List<Locale> _locales = [
    Locale('en', 'US'),
    Locale('en_US'),
    Locale('es', 'CO'),
    Locale('es_CO'),
  ];

  SplashController({
    @required IsAuthenticated isAuthenticated,
  })  : assert(isAuthenticated != null),
        _isAuthenticated = isAuthenticated;

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
