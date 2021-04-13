import 'package:get/get.dart';
import 'package:testquick/injection_container.dart';

import 'edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut<EditProfileController>(() => EditProfileController(
          updateUser: sl(),
          getCurrentUser: sl(),
        ));
  }
}
