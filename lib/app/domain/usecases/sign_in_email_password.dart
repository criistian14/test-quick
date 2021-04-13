import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/repositories/auth_repository.dart';

class SignInEmailPassword implements UseCase<UserModel, UserModel> {
  final AuthRepository repository;

  SignInEmailPassword({
    @required this.repository,
  });

  @override
  Future<Either<Failure, UserModel>> call(UserModel user) async {
    return await repository.signInWithEmail(user);
  }
}
