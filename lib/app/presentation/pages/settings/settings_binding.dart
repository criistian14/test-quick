import 'package:get/get.dart';
import 'package:testquick/injection_container.dart';

import 'settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut<SettingsController>(() => SettingsController(
          signOut: sl(),
        ));
  }
}
