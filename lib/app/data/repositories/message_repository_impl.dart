import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/utils/network_info.dart';
import 'package:testquick/app/data/datasources/remote/message_remote_data_source.dart';
import 'package:testquick/app/data/models/message_model.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MessageRepositoryImpl({
    @required this.remoteDataSource,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, Stream<List<MessageModel>>>> listenMessages(
    UserModel contact,
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

  @override
  Future<Either<Failure, MessageModel>> saveMessage(
      MessageModel message) async {
    try {
      final newMessage = await remoteDataSource.saveMessage(message);

      return Right(newMessage);
    } on ApiException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
      ));
    }
  }
}
