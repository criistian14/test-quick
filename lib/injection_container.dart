import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'app/core/utils/network_info.dart';
import 'app/data/datasources/remote/auth_remote_data_source.dart';
import 'app/data/repositories/auth_repository_impl.dart';
import 'app/domain/repositories/auth_repository.dart';
import 'app/domain/usecases/sign_in_email_password.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  _initUseCases();
  _initRepositories();
  _initDataSources();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );
  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
}

void _initUseCases() {
  // * Auth
  sl.registerLazySingleton(
    () => SignInEmailPassword(repository: sl()),
  );
}

void _initRepositories() {
  // * Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
}

void _initDataSources() {
  // * Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuthProvider: sl(),
      firebaseFirestore: sl(),
    ),
  );
}
