import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/core/utils/modals.dart';
import 'package:testquick/app/core/utils/time.dart';
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

  ImagePicker picker = ImagePicker();

  FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  bool _soundRecorderIsInited = false;
  bool soundRecorderStarted = false;
  Timer _timerSoundRecorder;

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
  void onInit() async {
    super.onInit();

    // Initialize FlutterSoundRecorder
    await _soundRecorder.openAudioSession();
    _soundRecorderIsInited = true;
  }

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

  void sendText() async {
    if (soundRecorderStarted) return;

    MessageModel message = MessageModel(
      message: messageText.value,
      idTo: contact.uid,
    );

    _sendMessage(message);

    // Clear input field
    messageFieldCtrl.clear();
    update(['field']);
  }

  void sendPicture() async {
    ImageSource source = await ModalsUtils.pickSourceImage();
    if (source == null) return;

    final pickedFile = await picker.getImage(source: source);
    if (pickedFile == null) return;

    MessageModel message = MessageModel(
      pictureFile: File(pickedFile.path),
      idTo: contact.uid,
    );

    _sendMessage(message);
  }

  void startRecordVoiceNote() async {
    if (!_soundRecorderIsInited) return;

    soundRecorderStarted = true;
    messageFieldCtrl.text = TimeUtils().transformSecondsToTime(0);
    update(["field"]);

    _timerSoundRecorder = Timer.periodic(Duration(seconds: 1), (timer) {
      messageFieldCtrl.text = TimeUtils().transformSecondsToTime(timer.tick);
      update(["field"]);
    });

    await _soundRecorder.startRecorder(
      toFile: "voice_note.acc",
      codec: Codec.aacMP4,
    );
  }

  void sendVoiceNote() async {
    soundRecorderStarted = false;
    _timerSoundRecorder?.cancel();
    messageFieldCtrl.clear();
    update(["field"]);

    String pathAudio = await _soundRecorder.stopRecorder();
    if (pathAudio.isEmpty) return;

    MessageModel message = MessageModel(
      audioFile: File(pathAudio),
      idTo: contact.uid,
    );

    _sendMessage(message);
  }

  void _sendMessage(MessageModel message) async {
    if (messagesList.isNotEmpty) {
      message = message.copyWith(
        idConversation: messagesList[0].idConversation,
      );
    }

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
    _soundRecorder.closeAudioSession();
    _soundRecorder = null;

    super.onClose();
  }
}
