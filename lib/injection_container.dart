import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'app/core/utils/network_info.dart';
import 'app/data/datasources/local/theme_local_data_source.dart';
import 'app/data/datasources/remote/auth_remote_data_source.dart';
import 'app/data/datasources/remote/contact_remote_data_source.dart';
import 'app/data/datasources/remote/conversation_remote_data_source.dart';
import 'app/data/datasources/remote/message_remote_data_source.dart';
import 'app/data/datasources/remote/user_remote_data_source.dart';
import 'app/data/repositories/auth_repository_impl.dart';
import 'app/data/repositories/contact_repository_impl.dart';
import 'app/data/repositories/conversation_repository_impl.dart';
import 'app/data/repositories/message_repository_impl.dart';
import 'app/data/repositories/theme_repository_impl.dart';
import 'app/data/repositories/user_repository_impl.dart';
import 'app/domain/repositories/auth_repository.dart';
import 'app/domain/repositories/contact_repository.dart';
import 'app/domain/repositories/conversation_repository.dart';
import 'app/domain/repositories/message_repository.dart';
import 'app/domain/repositories/theme_repository.dart';
import 'app/domain/repositories/user_repository.dart';
import 'app/domain/usecases/get_current_user.dart';
import 'app/domain/usecases/get_theme.dart';
import 'app/domain/usecases/is_authenticated.dart';
import 'app/domain/usecases/listen_contacts.dart';
import 'app/domain/usecases/listen_conversations.dart';
import 'app/domain/usecases/listen_messages.dart';
import 'app/domain/usecases/save_message.dart';
import 'app/domain/usecases/set_theme.dart';
import 'app/domain/usecases/sign_in_email_password.dart';
import 'app/domain/usecases/sign_out.dart';
import 'app/domain/usecases/stop_listening_contacts.dart';
import 'app/domain/usecases/stop_listening_conversations.dart';
import 'app/domain/usecases/stop_listening_messages.dart';
import 'app/domain/usecases/update_user.dart';

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
  sl.registerLazySingleton<FirebaseStorage>(
    () => FirebaseStorage.instance,
  );
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );
}

void _initUseCases() {
  // * Auth
  sl.registerLazySingleton(
    () => SignInEmailPassword(repository: sl()),
  );
  sl.registerLazySingleton(
    () => IsAuthenticated(repository: sl()),
  );
  sl.registerLazySingleton(
    () => SignOut(repository: sl()),
  );

  // * Conversations
  sl.registerLazySingleton(
    () => ListenConversations(repository: sl()),
  );
  sl.registerLazySingleton(
    () => StopListeningConversations(repository: sl()),
  );

  // * Contacts
  sl.registerLazySingleton(
    () => ListenContacts(repository: sl()),
  );
  sl.registerLazySingleton(
    () => StopListeningContacts(repository: sl()),
  );

  // * Messages
  sl.registerLazySingleton(
    () => ListenMessages(repository: sl()),
  );
  sl.registerLazySingleton(
    () => StopListeningMessages(repository: sl()),
  );
  sl.registerLazySingleton(
    () => SaveMessage(repository: sl()),
  );

  // * Users
  sl.registerLazySingleton(
    () => UpdateUser(repository: sl()),
  );
  sl.registerLazySingleton(
    () => GetCurrentUser(repository: sl()),
  );

  // * Theme
  sl.registerLazySingleton(
    () => GetTheme(repository: sl()),
  );
  sl.registerLazySingleton(
    () => SetTheme(repository: sl()),
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

  // * Conversations
  sl.registerLazySingleton<ConversationRepository>(
    () => ConversationRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // * Contacts
  sl.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // * Messages
  sl.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // * Users
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // * Theme
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(
      localDataSource: sl(),
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

  // * Conversations
  sl.registerLazySingleton<ConversationRemoteDataSource>(
    () => ConversationRemoteDataSourceImpl(
      firebaseAuthProvider: sl(),
      firebaseFirestore: sl(),
    ),
  );

  // * Contacts
  sl.registerLazySingleton<ContactRemoteDataSource>(
    () => ContactRemoteDataSourceImpl(
      firebaseAuthProvider: sl(),
      firebaseFirestore: sl(),
    ),
  );

  // * Messages
  sl.registerLazySingleton<MessageRemoteDataSource>(
    () => MessageRemoteDataSourceImpl(
      firebaseAuthProvider: sl(),
      firebaseFirestore: sl(),
      firebaseStorage: sl(),
    ),
  );

  // * Users
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      firebaseAuthProvider: sl(),
      firebaseFirestore: sl(),
      firebaseStorage: sl(),
    ),
  );

  // * Theme
  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(
      storage: sl(),
    ),
  );
}
