import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:get/get.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/data/models/message_model.dart';
import 'package:testquick/app/domain/entities/message.dart';
import 'package:testquick/app/domain/entities/user.dart';

abstract class MessageRemoteDataSource {
  /// Calls the TestQuick api to Firebase, collections("message").snapshot()
  ///
  /// Throws a [ServerFailure] for all error codes.
  Stream<List<Message>> listenMessages(User contact);

  /// Calls the close() by stream conversations
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<void> stopListeningMessages();
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final FirebaseAuth firebaseAuthProvider;
  final FirebaseFirestore firebaseFirestore;

  StreamController<List<Message>> streamMessages;

  MessageRemoteDataSourceImpl({
    this.firebaseAuthProvider,
    this.firebaseFirestore,
  });

  @override
  Stream<List<Message>> listenMessages(User contact) {
    try {
      var currentUser = firebaseAuthProvider.currentUser;
      if (currentUser == null) {
        throw ApiException(
          code: 401,
          error: "failed_user_not_signed".tr,
        );
      }

      streamMessages = StreamController<List<Message>>();

      firebaseFirestore
          .collection("conversations")
          .where("users", arrayContains: currentUser.uid)
          .get()
          .then((conversationsFirestore) {
        //    Validar con el contact
        var conversationFound;
        for (var doc in conversationsFirestore.docs) {
          conversationFound = (doc.data()["users"] as List)
              .firstWhere((userId) => userId == contact.uid, orElse: () {});

          if (conversationFound != null) break;
        }
        if (conversationFound == null) return;

        Stream<QuerySnapshot> messagesFirestore = firebaseFirestore
            .collection("conversations")
            .doc(conversationsFirestore.docs[0].id)
            .collection("messages")
            .orderBy("created_at", descending: true)
            .snapshots();

        List<Message> messages = [];

        // Listen to changes in firebase messages
        messagesFirestore.listen((QuerySnapshot query) async {
          messages.clear();
          MessageModel message;

          for (QueryDocumentSnapshot doc in query.docs) {
            message = MessageModel.fromJson(doc.data());
            messages.add(message);
          }

          // Add new list message to stream
          streamMessages.add(messages);
        });
      });

      return streamMessages.stream;
    } catch (e) {
      throw ApiException(
        error: e.toString(),
      );
    }
  }

  Future<void> stopListeningMessages() async {
    await streamMessages?.close();
  }
}
