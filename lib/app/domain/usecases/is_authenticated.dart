import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/domain/repositories/auth_repository.dart';

class IsAuthenticated implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  IsAuthenticated({
    @required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams _) async {
    return await repository.checkIsAuthenticated();
  }
}
