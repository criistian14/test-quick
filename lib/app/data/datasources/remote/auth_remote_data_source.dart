import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, UserCredential, FirebaseAuthException;
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Calls the TestQuick api to Firebase, signInWithEmailAndPassword()
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<UserModel> signInWithEmail(UserModel user);

  /// Calls the TestQuick api to Firebase, currentUser
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<bool> checkIsAuthenticated();

  /// Calls the TestQuick api to Firebase, signOut()
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuthProvider;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl({
    @required this.firebaseAuthProvider,
    @required this.firebaseFirestore,
  });

  @override
  Future<UserModel> signInWithEmail(UserModel user) async {
    UserCredential userCredential;
    DocumentSnapshot userFireStore;

    try {
      userCredential = await firebaseAuthProvider.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      userFireStore = await firebaseFirestore
          .collection('users')
          .doc(userCredential.user.uid)
          .get();

      if (!userFireStore.exists) {
        throw FirebaseAuthException(code: "user-not-found");
      }

      UserModel userFound = UserModel.fromJson(userFireStore.data());
      userFound = userFound.copyWith(
        uid: userCredential.user.uid,
      );

      return userFound;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ApiException(
          error: "failed_user_not_found".tr,
        );
      } else if (e.code == 'wrong-password') {
        throw ApiException(
          error: "failed_sign_in".tr,
        );
      }

      throw ApiException(
        error: e.message,
      );
    } catch (e) {
      throw ApiException(
        error: e.toString(),
      );
    }
  }

  @override
  Future<bool> checkIsAuthenticated() async {
    if (firebaseAuthProvider.currentUser != null) {
      return true;
    }

    return false;
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuthProvider.signOut();
    } catch (e) {
      throw ApiException(
        error: e.toString(),
      );
    }
  }
}
