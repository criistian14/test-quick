import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/utils/network_info.dart';
import 'package:testquick/app/data/datasources/remote/conversation_remote_data_source.dart';
import 'package:testquick/app/domain/entities/conversation.dart';
import 'package:testquick/app/domain/repositories/conversation_repository.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ConversationRepositoryImpl({
    @required this.remoteDataSource,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, Stream<List<Conversation>>>>
      listenConversations() async {
    try {
      return Right(remoteDataSource.listenConversations());
    } on ApiException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
      ));
    }
  }

  @override
  Future<Either<Failure, Future<void>>> stopListeningConversations() async {
    try {
      await remoteDataSource.stopListeningConversations();

      return Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
      ));
    }
  }
}
