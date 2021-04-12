import 'package:equatable/equatable.dart';
import 'package:testquick/app/domain/entities/message.dart';
import 'package:testquick/app/domain/entities/user.dart';

class Conversation extends Equatable {
  final String id, meUid;
  final List<Message> messages;
  final List<User> users;
  final Message lastMessage;

  Conversation({
    this.id,
    this.meUid,
    this.messages,
    this.users,
    this.lastMessage,
  });

  @override
  List<Object> get props => [
        id,
        meUid,
        messages,
        users,
        lastMessage,
      ];
}
