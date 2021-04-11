import 'package:equatable/equatable.dart';
import 'package:testquick/app/domain/entities/message.dart';
import 'package:testquick/app/domain/entities/user.dart';

class Conversation extends Equatable {
  final String meUid;
  final List<Message> messages;
  final List<User> users;
  final Message lastMessage;

  Conversation({
    this.meUid,
    this.messages,
    this.users,
    this.lastMessage,
  });

  @override
  List<Object> get props => [
        meUid,
        messages,
        users,
        lastMessage,
      ];
}