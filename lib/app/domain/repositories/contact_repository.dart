import 'package:dartz/dartz.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/data/models/user_model.dart';

abstract class ContactRepository {
  // Listen contacts list
  Future<Either<Failure, Stream<List<UserModel>>>> listenContacts();

  // Stop listening contacts list
  Future<Either<Failure, Future<void>>> stopListeningContacts();
}
