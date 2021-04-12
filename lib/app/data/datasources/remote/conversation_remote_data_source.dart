import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:get/get.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/data/models/conversation_model.dart';
import 'package:testquick/app/data/models/user_model.dart';

abstract class ConversationRemoteDataSource {
  /// Calls the TestQuick api to Firebase, collections("conversations").snapshot()
  ///
  /// Throws a [ServerFailure] for all error codes.
  Stream<List<ConversationModel>> listenConversations();

  /// Calls the close() by stream conversations
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<void> stopListeningConversations();
}

class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  final FirebaseAuth firebaseAuthProvider;
  final FirebaseFirestore firebaseFirestore;

  StreamController<List<ConversationModel>> _streamConversations;
  StreamSubscription<QuerySnapshot> _streamConversationsFirestore;

  ConversationRemoteDataSourceImpl({
    this.firebaseAuthProvider,
    this.firebaseFirestore,
  });

  @override
  Stream<List<ConversationModel>> listenConversations() {
    try {
      var currentUser = firebaseAuthProvider.currentUser;
      if (currentUser == null) {
        throw ApiException(
          code: 401,
          error: "failed_user_not_signed".tr,
        );
      }

      _streamConversations = StreamController<List<ConversationModel>>();

      Stream<QuerySnapshot> conversationsFirestore = firebaseFirestore
          .collection("conversations")
          .where("users", arrayContains: currentUser.uid)
          .snapshots();

      List<ConversationModel> conversations = [];

      // Listen to changes in firebase conversations
      _streamConversationsFirestore =
          conversationsFirestore.listen((QuerySnapshot query) async {
        ConversationModel conversation;
        conversations.clear();

        for (QueryDocumentSnapshot doc in query.docs) {
          if (doc.data()["users"] == null) {
            break;
          }

          List<UserModel> users = await _getUsersByConversation(
            doc.data()["users"],
          );

          if (doc.data()["last_message"] == null) continue;

          // Parse conversation
          conversation = ConversationModel.fromFirestore(doc);
          conversations.add(conversation.copyWith(
            meUid: currentUser.uid,
            users: users,
          ));
        }

        // Add new list conversation to stream
        _streamConversations.add(conversations);
      });

      return _streamConversations.stream;
    } catch (e) {
      throw ApiException(
        error: e.toString(),
      );
    }
  }

  Future<List<UserModel>> _getUsersByConversation(List data) async {
    return await Future.wait(data.map((uid) async {
      var userFireStore =
          await firebaseFirestore.collection("users").doc(uid).get();

      UserModel userFound = UserModel.fromJson(
        userFireStore.data(),
      );

      userFound = userFound.copyWith(
        uid: uid,
      );

      return userFound;
    }).toList());
  }

  Future<void> stopListeningConversations() async {
    await _streamConversations?.close();
    await _streamConversationsFirestore?.cancel();
  }
}
