import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/domain/entities/user.dart';
import 'package:testquick/app/domain/repositories/contact_repository.dart';

class ListenContacts implements UseCase<Stream<List<User>>, NoParams> {
  final ContactRepository repository;

  ListenContacts({
    @required this.repository,
  });

  @override
  Future<Either<Failure, Stream<List<User>>>> call(NoParams _) async {
    return await repository.listenContacts();
  }
}
