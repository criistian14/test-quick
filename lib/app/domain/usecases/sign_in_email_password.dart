import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/domain/entities/user.dart';
import 'package:testquick/app/domain/repositories/auth_repository.dart';

class SignInEmailPassword implements UseCase<User, User> {
  final AuthRepository repository;

  SignInEmailPassword({
    @required this.repository,
  });

  @override
  Future<Either<Failure, User>> call(User user) async {
    return await repository.signInWithEmail(user);
  }
}
