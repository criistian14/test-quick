import 'package:dartz/dartz.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/domain/entities/user.dart';

abstract class ContactRepository {
  // Listen contacts list
  Future<Either<Failure, Stream<List<User>>>> listenContacts();

  // Stop listening contacts list
  Future<Either<Failure, Future<void>>> stopListeningContacts();
}
