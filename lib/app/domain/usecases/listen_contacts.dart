import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/repositories/contact_repository.dart';

class ListenContacts implements UseCase<Stream<List<UserModel>>, NoParams> {
  final ContactRepository repository;

  ListenContacts({
    @required this.repository,
  });

  @override
  Future<Either<Failure, Stream<List<UserModel>>>> call(NoParams _) async {
    return await repository.listenContacts();
  }
}
