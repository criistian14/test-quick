import 'dart:async';

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/entities/message.dart';
import 'package:testquick/app/domain/usecases/listen_messages.dart';
import 'package:testquick/app/domain/usecases/stop_listening_messages.dart';

class ChatController extends GetxController {
  final ListenMessages _getMessages;
  final StopListeningMessages _stopListeningMessages;

  UserModel contact = UserModel();
  StreamSubscription _messagesListStream;
  RxList<Message> messagesList = <Message>[].obs;
  RxBool loading = false.obs;

  ChatController({
    @required ListenMessages getMessages,
    @required StopListeningMessages stopListeningMessages,
  })  : assert(getMessages != null),
        assert(stopListeningMessages != null),
        _getMessages = getMessages,
        _stopListeningMessages = stopListeningMessages;

  @override
  void onReady() async {
    super.onReady();

    var arguments = Get.arguments;
    if (arguments == null) {
      Get.back();
    }

    contact = arguments["user"];
    update();

    getMessages();
  }

  void getMessages() async {
    loading.value = true;

    var getMessagesCall = await _getMessages.call(contact);
    getMessagesCall.fold(Alerts.errorAlertUseCase, (r) {
      _messagesListStream = r.listen((event) {
        messagesList.assignAll(event);
      });

      // prevent abrupt change
      Future.delayed(Duration(milliseconds: 600), () {
        loading.value = false;
      });
    });
  }

  @override
  void onClose() async {
    await _messagesListStream?.cancel();
    var stopListeningMessagesCall =
        await _stopListeningMessages.call(NoParams());
    stopListeningMessagesCall.fold(Alerts.errorAlertUseCase, (r) {});

    super.onClose();
  }
}
