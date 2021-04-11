import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/domain/entities/message.dart';
import 'package:testquick/app/domain/entities/user.dart';
import 'package:testquick/app/domain/repositories/message_repository.dart';

class ListenMessages implements UseCase<Stream<List<Message>>, User> {
  final MessageRepository repository;

  ListenMessages({
    @required this.repository,
  });

  @override
  Future<Either<Failure, Stream<List<Message>>>> call(
    User contact,
  ) async {
    return await repository.listenMessages(contact);
  }
}
