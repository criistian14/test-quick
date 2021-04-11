import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/data/models/message_model.dart';
import 'package:testquick/app/domain/repositories/message_repository.dart';

class SaveMessage implements UseCase<MessageModel, MessageModel> {
  final MessageRepository repository;

  SaveMessage({
    @required this.repository,
  });

  @override
  Future<Either<Failure, MessageModel>> call(MessageModel message) async {
    return await repository.saveMessage(message);
  }
}
