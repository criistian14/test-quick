import 'package:get/get.dart';
import 'package:testquick/app/core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(
      Duration(milliseconds: 800),
    );

    Get.offNamedUntil(AppRoutes.HOME, (route) => false);
  }
}
