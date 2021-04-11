import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/data/models/message_model.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/entities/form/custom_field_form.dart';
import 'package:testquick/app/domain/usecases/listen_messages.dart';
import 'package:testquick/app/domain/usecases/save_message.dart';
import 'package:testquick/app/domain/usecases/stop_listening_messages.dart';

class ChatController extends GetxController {
  final ListenMessages _getMessages;
  final StopListeningMessages _stopListeningMessages;
  final SaveMessage _saveMessage;

  UserModel contact = UserModel();
  StreamSubscription _messagesListStream;
  RxList<MessageModel> messagesList = <MessageModel>[].obs;
  RxBool loading = false.obs;

  CustomFieldForm messageText = CustomFieldForm.pure();
  TextEditingController messageFieldCtrl = TextEditingController();

  ChatController({
    @required ListenMessages getMessages,
    @required StopListeningMessages stopListeningMessages,
    @required SaveMessage saveMessage,
  })  : assert(getMessages != null),
        assert(stopListeningMessages != null),
        assert(saveMessage != null),
        _getMessages = getMessages,
        _stopListeningMessages = stopListeningMessages,
        _saveMessage = saveMessage;

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
      messagesList.clear();

      _messagesListStream = r.listen((event) {
        messagesList.assignAll(event);
      });

      // prevent abrupt change
      Future.delayed(Duration(milliseconds: 600), () {
        loading.value = false;
      });
    });
  }

  // * Change values
  void changeMessage(String message) {
    this.messageText = CustomFieldForm.dirty(message);
    update(['field']);
  }

  bool isEmptyField() {
    return messageFieldCtrl.text.length == 0;
  }

  void sendMessage() async {
    MessageModel message = MessageModel(
      message: messageText.value,
      idTo: contact.uid,
    );

    if (messagesList.isNotEmpty) {
      message = message.copyWith(
        idConversation: messagesList[0].idConversation,
      );
    }

    // Clear input field
    messageFieldCtrl.clear();
    update(['field']);

    var saveMessageCall = await _saveMessage.call(message);
    saveMessageCall.fold(Alerts.errorAlertUseCase, (r) async {
      if (messagesList.isEmpty) {
        await stopListeningMessages();
        getMessages();
      }
    });
  }

  Future<void> stopListeningMessages() async {
    await _messagesListStream?.cancel();
    var stopListeningMessagesCall =
        await _stopListeningMessages.call(NoParams());
    stopListeningMessagesCall.fold(Alerts.errorAlertUseCase, (r) {});
  }

  @override
  void onClose() async {
    await stopListeningMessages();

    super.onClose();
  }
}
