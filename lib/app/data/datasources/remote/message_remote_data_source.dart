import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:get/get.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/data/models/conversation_model.dart';
import 'package:testquick/app/data/models/message_model.dart';
import 'package:testquick/app/data/models/user_model.dart';

abstract class MessageRemoteDataSource {
  /// Calls the TestQuick api to Firebase, collections("message").snapshot()
  ///
  /// Throws a [ServerFailure] for all error codes.
  Stream<List<MessageModel>> listenMessages(UserModel contact);

  /// Calls the close() by stream conversations
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<void> stopListeningMessages();

  /// Calls the TestQuick api to Firebase, add()
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<MessageModel> saveMessage(MessageModel message);
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final FirebaseAuth firebaseAuthProvider;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  StreamController<List<MessageModel>> _streamMessages;
  StreamSubscription<QuerySnapshot> _streamMessagesFirestore;

  MessageRemoteDataSourceImpl({
    this.firebaseAuthProvider,
    this.firebaseFirestore,
    this.firebaseStorage,
  });

  @override
  Stream<List<MessageModel>> listenMessages(UserModel contact) {
    try {
      var currentUser = firebaseAuthProvider.currentUser;
      if (currentUser == null) {
        throw ApiException(
          code: 401,
          error: "failed_user_not_signed".tr,
        );
      }

      _streamMessages = StreamController<List<MessageModel>>();

      // Validate if the conversation exists
      _checkConversationAlreadyExists(
        currentUserId: currentUser.uid,
        contactId: contact.uid,
      ).then((conversationFound) {
        if (conversationFound == null) return;

        Stream<QuerySnapshot> messagesFirestore = firebaseFirestore
            .collection("conversations")
            .doc(conversationFound.id)
            .collection("messages")
            .orderBy("created_at", descending: true)
            .snapshots();

        List<MessageModel> messages = [];

        // Listen to changes in firebase messages
        _streamMessagesFirestore =
            messagesFirestore.listen((QuerySnapshot query) async {
          await _markMessageRead(
            idConversation: conversationFound.id,
            contactId: contact.uid,
          );

          messages.clear();
          MessageModel message;

          for (QueryDocumentSnapshot doc in query.docs) {
            message = MessageModel.fromJson(doc.data());
            messages.add(message.copyWith(
              idConversation: conversationFound.id,
            ));
          }

          // Add new list message to stream
          _streamMessages.add(messages);
        });
      });

      return _streamMessages.stream;
    } catch (e) {
      throw ApiException(
        error: e.toString(),
      );
    }
  }

  Future<void> stopListeningMessages() async {
    await _streamMessages?.close();
    await _streamMessagesFirestore?.cancel();
  }

  @override
  Future<MessageModel> saveMessage(MessageModel message) async {
    try {
      var currentUser = firebaseAuthProvider.currentUser;
      if (currentUser == null) {
        throw ApiException(
          code: 401,
          error: "failed_user_not_signed".tr,
        );
      }

      // Add values to message
      message = message.copyWith(
        idFrom: currentUser.uid,
      );
      var createAt = FieldValue.serverTimestamp();

      final conversationId = await _checkIdConversation(
        message: message,
        currentUserId: currentUser.uid,
      );
      message.copyWith(
        idConversation: conversationId,
      );

      // Update last message
      DocumentReference conversation = firebaseFirestore
          .collection("conversations")
          .doc(message.idConversation);

      // If the message is a picture
      if (message.pictureFile != null) {
        final uploadTask = await firebaseStorage
            .ref()
            .child(
              "/messages/images/${message.pictureFile.path.split("/").last}",
            )
            .putFile(message.pictureFile);

        await uploadTask.ref.getDownloadURL().then((fileURL) {
          message = message.copyWith(
            picture: fileURL,
          );
        });
      }

      await conversation.update({
        "last_message": {
          ...message.toJson(),
          "created_at": createAt,
        },
      });

      // Add new message
      CollectionReference messages = conversation.collection("messages");
      messages.add({
        ...message.toJson(),
        "created_at": createAt,
      });

      return message;
    } catch (e) {
      throw ApiException(
        error: e.toString(),
      );
    }
  }

  // * Check if there is a conversation with the current user and the contact.
  Future<QueryDocumentSnapshot> _checkConversationAlreadyExists({
    String currentUserId,
    String contactId,
  }) async {
    QuerySnapshot conversationsFirestore = await firebaseFirestore
        .collection("conversations")
        .where("users", arrayContains: currentUserId)
        .get();

    QueryDocumentSnapshot conversationFound;
    for (var doc in conversationsFirestore.docs) {
      var userFound = (doc.data()["users"] as List)
          .firstWhere((userId) => userId == contactId, orElse: () {});

      if (userFound != null) {
        conversationFound = doc;
        break;
      }
    }

    return conversationFound;
  }

  // * Mark as read the last_message and also all messages from the sender.
  Future<void> _markMessageRead({
    String idConversation,
    String contactId,
  }) async {
    // Update last message
    DocumentReference conversationReference =
        firebaseFirestore.collection("conversations").doc(idConversation);

    DocumentSnapshot conversationData = await conversationReference.get();
    ConversationModel conversation =
        ConversationModel.fromFirestore(conversationData);

    // Only update if the message is from the contact (sender)
    if (conversation.lastMessage.idFrom == contactId) {
      await conversationReference.update({
        "last_message.read": true,
      });
    }

    // Update messages
    CollectionReference messages = conversationReference.collection("messages");
    WriteBatch batch = firebaseFirestore.batch();

    QuerySnapshot messagesContact =
        await messages.where("id_from", isEqualTo: contactId).get();

    messagesContact.docs.forEach((message) {
      batch.update(message.reference, {
        "read": true,
      });
    });

    batch.commit();
  }

  Future<String> _checkIdConversation({
    @required MessageModel message,
    @required currentUserId,
  }) async {
    if (message.idConversation != null) return message.idConversation;

    // Check if the conversation is already started
    QueryDocumentSnapshot conversationFound =
        await _checkConversationAlreadyExists(
      currentUserId: currentUserId,
      contactId: message.idTo,
    );

    if (conversationFound != null) {
      return conversationFound.id;
    }

    // Create new conversation if it does not exist
    CollectionReference conversations =
        firebaseFirestore.collection("conversations");

    DocumentReference newConversation = await conversations.add({
      "last_message": null,
      "users": [
        message.idFrom,
        message.idTo,
      ],
    });

    return newConversation.id;
  }
}
