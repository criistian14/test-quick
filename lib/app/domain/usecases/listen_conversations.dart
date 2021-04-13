import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/data/models/conversation_model.dart';
import 'package:testquick/app/domain/repositories/conversation_repository.dart';

class ListenConversations
    implements UseCase<Stream<List<ConversationModel>>, NoParams> {
  final ConversationRepository repository;

  ListenConversations({
    @required this.repository,
  });

  @override
  Future<Either<Failure, Stream<List<ConversationModel>>>> call(
    NoParams _,
  ) async {
    return await repository.listenConversations();
  }
}
