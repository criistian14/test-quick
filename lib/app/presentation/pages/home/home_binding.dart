import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.put<HomeController>(HomeController());
  }
}
