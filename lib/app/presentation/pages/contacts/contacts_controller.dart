import 'dart:async';

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/domain/entities/user.dart';
import 'package:testquick/app/domain/usecases/listen_contacts.dart';
import 'package:testquick/app/domain/usecases/stop_listening_contacts.dart';

class ContactsController extends GetxController {
  final ListenContacts _getContacts;
  final StopListeningContacts _stopListeningContacts;

  StreamSubscription _contactsListStream;
  RxList<User> contactsList = <User>[].obs;
  RxBool loading = false.obs;

  ContactsController({
    @required ListenContacts getContacts,
    @required StopListeningContacts stopListeningContacts,
  })  : assert(getContacts != null),
        assert(stopListeningContacts != null),
        _getContacts = getContacts,
        _stopListeningContacts = stopListeningContacts;

  @override
  void onReady() {
    super.onReady();

    getContacts();
  }

  void getContacts() async {
    loading.value = true;
    var getContactsCall = await _getContacts.call(NoParams());
    getContactsCall.fold(Alerts.errorAlertUseCase, (r) {
      _contactsListStream = r.listen((event) {
        contactsList.assignAll(event);
        loading.value = false;
      });
    });
  }

  void goChat({User contact}) {}

  @override
  void onClose() async {
    await _contactsListStream?.cancel();
    var stopListeningContactsCall =
        await _stopListeningContacts.call(NoParams());
    stopListeningContactsCall.fold(Alerts.errorAlertUseCase, (r) {});

    super.onClose();
  }
}
