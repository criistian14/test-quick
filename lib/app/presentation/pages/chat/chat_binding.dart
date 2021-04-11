import 'package:get/get.dart';
import 'package:testquick/injection_container.dart';

import 'chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut<ChatController>(() => ChatController(
          getMessages: sl(),
          stopListeningMessages: sl(),
          saveMessage: sl(),
        ));
  }
}
