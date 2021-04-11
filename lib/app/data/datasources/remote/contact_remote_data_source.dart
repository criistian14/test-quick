import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:get/get.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/data/models/user_model.dart';

abstract class ContactRemoteDataSource {
  /// Calls the TestQuick api to Firebase, collections("users").snapshot()
  ///
  /// Throws a [ServerFailure] for all error codes.
  Stream<List<UserModel>> listenContacts();

  /// Calls the close() by stream contacts
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<void> stopListeningContacts();
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final FirebaseAuth firebaseAuthProvider;
  final FirebaseFirestore firebaseFirestore;

  StreamController<List<UserModel>> _streamContacts;
  StreamSubscription<QuerySnapshot> _streamContactsFirestore;

  ContactRemoteDataSourceImpl({
    this.firebaseAuthProvider,
    this.firebaseFirestore,
  });

  @override
  Stream<List<UserModel>> listenContacts() {
    try {
      var currentUser = firebaseAuthProvider.currentUser;
      if (currentUser == null) {
        throw ApiException(
          code: 401,
          error: "failed_user_not_signed".tr,
        );
      }

      _streamContacts = StreamController<List<UserModel>>();

      Stream<QuerySnapshot> contactsFirestore =
          firebaseFirestore.collection("users").snapshots();

      List<UserModel> contacts = [];

      // Listen to changes in firebase contacts
      _streamContactsFirestore =
          contactsFirestore.listen((QuerySnapshot query) async {
        contacts.clear();
        UserModel contact;

        for (QueryDocumentSnapshot doc in query.docs) {
          // ! Not save data the signed user
          if (doc.id == currentUser.uid) {
            continue;
          }

          contact = UserModel.fromJson(doc.data());
          contacts.add(contact.copyWith(
            uid: doc.id,
          ));
        }

        // Add new list contact to stream
        _streamContacts.add(contacts);
      });

      return _streamContacts.stream;
    } catch (e) {
      throw ApiException(
        error: e.toString(),
      );
    }
  }

  @override
  Future<void> stopListeningContacts() async {
    await _streamContacts?.close();
    await _streamContactsFirestore?.cancel();
  }
}
