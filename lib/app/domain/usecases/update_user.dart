import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/repositories/user_repository.dart';

class UpdateUser implements UseCase<UserModel, UserModel> {
  final UserRepository repository;

  UpdateUser({
    @required this.repository,
  });

  @override
  Future<Either<Failure, UserModel>> call(UserModel user) async {
    return await repository.updateUser(user);
  }
}
