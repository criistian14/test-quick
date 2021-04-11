import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:get/get.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/entities/user.dart';

abstract class ContactRemoteDataSource {
  /// Calls the TestQuick api to Firebase, collections("users").snapshot()
  ///
  /// Throws a [ServerFailure] for all error codes.
  Stream<List<User>> listenContacts();

  /// Calls the close() by stream contacts
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<void> stopListeningContacts();
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final FirebaseAuth firebaseAuthProvider;
  final FirebaseFirestore firebaseFirestore;

  StreamController<List<User>> streamContacts;

  ContactRemoteDataSourceImpl({
    this.firebaseAuthProvider,
    this.firebaseFirestore,
  });

  @override
  Stream<List<User>> listenContacts() {
    try {
      var currentUser = firebaseAuthProvider.currentUser;
      if (currentUser == null) {
        throw ApiException(
          code: 401,
          error: "failed_user_not_signed".tr,
        );
      }

      streamContacts = StreamController<List<User>>();

      Stream<QuerySnapshot> contactsFirestore =
          firebaseFirestore.collection("users").snapshots();

      List<User> contacts = [];

      // Listen to changes in firebase contacts
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
        streamContacts.add(contacts);
      });

      return streamContacts.stream;
    } catch (e) {
      throw ApiException(
        error: e.toString(),
      );
    }
  }

  @override
  Future<void> stopListeningContacts() async {
    await streamContacts?.close();
  }
}
