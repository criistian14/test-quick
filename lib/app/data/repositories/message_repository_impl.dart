import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/utils/network_info.dart';
import 'package:testquick/app/data/datasources/remote/message_remote_data_source.dart';
import 'package:testquick/app/domain/entities/message.dart';
import 'package:testquick/app/domain/entities/user.dart';
import 'package:testquick/app/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MessageRepositoryImpl({
    @required this.remoteDataSource,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, Stream<List<Message>>>> listenMessages(
    User contact,
  ) async {
    try {
      return Right(remoteDataSource.listenMessages(contact));
    } on ApiException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
      ));
    }
  }

  @override
  Future<Either<Failure, Future<void>>> stopListeningMessages() async {
    try {
      await remoteDataSource.stopListeningMessages();

      return Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
      ));
    }
  }
}
