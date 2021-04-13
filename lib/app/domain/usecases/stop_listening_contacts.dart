import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/domain/repositories/contact_repository.dart';

class StopListeningContacts implements UseCase<void, NoParams> {
  final ContactRepository repository;

  StopListeningContacts({
    @required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(NoParams _) async {
    return await repository.stopListeningContacts();
  }
}
