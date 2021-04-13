import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/repositories/user_repository.dart';

class GetCurrentUser implements UseCase<UserModel, NoParams> {
  final UserRepository repository;

  GetCurrentUser({
    @required this.repository,
  });

  @override
  Future<Either<Failure, UserModel>> call(NoParams _) async {
    return await repository.getCurrentUser();
  }
}
