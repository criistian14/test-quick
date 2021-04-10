import 'dart:async';

import 'package:get/get.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/domain/entities/conversation.dart';
import 'package:testquick/app/domain/usecases/listen_conversations.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/domain/usecases/stop_listening_conversations.dart';

class ConversationsController extends GetxController {
  final ListenConversations _getConversations;
  final StopListeningConversations _stopListeningConversations;

  StreamSubscription _conversationListStream;
  RxList<Conversation> conversationsList = <Conversation>[].obs;
  RxBool loading = false.obs;

  ConversationsController({
    @required ListenConversations getConversations,
    @required StopListeningConversations stopListeningConversations,
  })  : assert(getConversations != null),
        assert(stopListeningConversations != null),
        _getConversations = getConversations,
        _stopListeningConversations = stopListeningConversations;

  @override
  void onReady() {
    super.onReady();

    getConversations();
  }

  void getConversations() async {
    loading.value = true;
    var getConversationsCall = await _getConversations.call(NoParams());
    getConversationsCall.fold(Alerts.errorAlertUseCase, (r) {
      _conversationListStream = r.listen((event) {
        conversationsList.assignAll(event);
        loading.value = false;
      });
    });
  }

  void goChat({
    Conversation conversation,
  }) {}

  @override
  void onClose() async {
    await _conversationListStream?.cancel();
    var stopListeningConversationsCall =
        await _stopListeningConversations.call(NoParams());
    stopListeningConversationsCall.fold(Alerts.errorAlertUseCase, (r) {});

    super.onClose();
  }
}
