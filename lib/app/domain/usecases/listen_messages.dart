import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/data/models/message_model.dart';
import 'package:testquick/app/domain/entities/user.dart';
import 'package:testquick/app/domain/repositories/message_repository.dart';

class ListenMessages implements UseCase<Stream<List<MessageModel>>, User> {
  final MessageRepository repository;

  ListenMessages({
    @required this.repository,
  });

  @override
  Future<Either<Failure, Stream<List<MessageModel>>>> call(
    User contact,
  ) async {
    return await repository.listenMessages(contact);
  }
}
