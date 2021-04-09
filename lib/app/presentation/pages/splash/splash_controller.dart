import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:testquick/app/core/routes/app_routes.dart';

class SplashController extends GetxController {
  List<Locale> _locales = [
    Locale('en', 'US'),
    Locale('en_US'),
    Locale('es', 'CO'),
    Locale('es_CO'),
  ];

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

    Get.offNamedUntil(AppRoutes.SIGN_IN, (route) => false);
  }
}
