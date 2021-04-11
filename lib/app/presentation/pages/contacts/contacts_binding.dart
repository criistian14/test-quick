import 'package:get/get.dart';
import 'package:testquick/injection_container.dart';

import 'contacts_controller.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut<ContactsController>(() => ContactsController(
          getContacts: sl(),
          stopListeningContacts: sl(),
        ));
  }
}
