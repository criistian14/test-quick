import 'package:get/get.dart';
import 'package:testquick/injection_container.dart';

import 'sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut<SignInController>(() => SignInController(
          signInEmailPassword: sl(),
        ));
  }
}
