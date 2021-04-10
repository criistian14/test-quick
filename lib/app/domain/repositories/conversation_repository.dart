import 'package:dartz/dartz.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/domain/entities/conversation.dart';

abstract class ConversationRepository {
  // Listen conversations list
  Future<Either<Failure, Stream<List<Conversation>>>> listenConversations();

  // Stop listening conversations list
  Future<Either<Failure, Future<void>>> stopListeningConversations();
}
