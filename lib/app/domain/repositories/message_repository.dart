import 'package:dartz/dartz.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/data/models/message_model.dart';
import 'package:testquick/app/data/models/user_model.dart';

abstract class MessageRepository {
  // Listen messages list by conversation
  Future<Either<Failure, Stream<List<MessageModel>>>> listenMessages(
    UserModel contact,
  );

  // Stop listening messages list
  Future<Either<Failure, Future<void>>> stopListeningMessages();

  // Add new message in conversation
  Future<Either<Failure, MessageModel>> saveMessage(
    MessageModel message,
  );
}
