import 'package:dartz/dartz.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/domain/entities/message.dart';
import 'package:testquick/app/domain/entities/user.dart';

abstract class MessageRepository {
  // Listen messages list by conversation
  Future<Either<Failure, Stream<List<Message>>>> listenMessages(
    User contact,
  );

  // Stop listening messages list
  Future<Either<Failure, Future<void>>> stopListeningMessages();
}
