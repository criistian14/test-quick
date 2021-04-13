import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/domain/repositories/conversation_repository.dart';

class StopListeningConversations implements UseCase<void, NoParams> {
  final ConversationRepository repository;

  StopListeningConversations({
    @required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(NoParams _) async {
    return await repository.stopListeningConversations();
  }
}
