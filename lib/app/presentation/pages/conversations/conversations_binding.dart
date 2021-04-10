import 'package:get/get.dart';
import 'package:testquick/injection_container.dart';

import 'conversations_controller.dart';

class ConversationsBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers
    Get.lazyPut<ConversationsController>(() => ConversationsController(
          getConversations: sl(),
          stopListeningConversations: sl(),
        ));
  }
}
