import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testquick/app/data/models/message_model.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/entities/conversation.dart';
import 'package:testquick/app/domain/entities/message.dart';

class ConversationModel extends Conversation {
  ConversationModel({
    String meUid,
    List<MessageModel> messages,
    List<UserModel> users,
    MessageModel lastMessage,
  }) : super(
          meUid: meUid,
          messages: messages,
          users: users,
          lastMessage: lastMessage,
        );

  factory ConversationModel.fromFirestore(DocumentSnapshot snapshot) {
    return ConversationModel(
      lastMessage: MessageModel.fromJson(snapshot.data()["last_message"]),
    );
  }

  ConversationModel copyWith({
    String meUid,
    List<Message> messages,
    List<UserModel> users,
    Message lastMessage,
  }) =>
      ConversationModel(
        meUid: meUid ?? this.meUid,
        messages: messages ?? this.messages,
        users: users ?? this.users,
        lastMessage: lastMessage ?? this.lastMessage,
      );
}
