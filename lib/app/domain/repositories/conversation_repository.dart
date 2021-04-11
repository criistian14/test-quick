import 'package:dartz/dartz.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/data/models/conversation_model.dart';

abstract class ConversationRepository {
  // Listen conversations list
  Future<Either<Failure, Stream<List<ConversationModel>>>>
      listenConversations();

  // Stop listening conversations list
  Future<Either<Failure, Future<void>>> stopListeningConversations();
}
