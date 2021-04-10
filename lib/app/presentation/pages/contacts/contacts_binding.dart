import 'package:get/get.dart';

import 'contacts_controller.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut<ContactsController>(() => ContactsController());
  }
}
