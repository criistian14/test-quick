import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:testquick/app/core/errors/exceptions.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:meta/meta.dart';

abstract class UserRemoteDataSource {
  /// Calls the TestQuick api to Firebase, update()
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<UserModel> updateUser(UserModel user);

  /// Calls the TestQuick api to Firebase, doc().get()
  ///
  /// Throws a [ServerFailure] for all error codes.
  Future<UserModel> getCurrentUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuthProvider;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  UserRemoteDataSourceImpl({
    @required this.firebaseAuthProvider,
    @required this.firebaseFirestore,
    @required this.firebaseStorage,
  });

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      var currentUser = firebaseAuthProvider.currentUser;
      if (currentUser == null) {
        throw ApiException(
          code: 401,
          error: "failed_user_not_signed".tr,
        );
      }

      // Get user
      DocumentReference userDocument =
          firebaseFirestore.collection("users").doc(currentUser.uid);

      // If the user change avatar
      if (user.avatarFile != null) {
        final uploadTask = await firebaseStorage
            .ref()
            .child(
              "/users/avatars/${currentUser.uid}.${user.avatarFile.path.split(".").last}",
            )
            .putFile(user.avatarFile);

        await uploadTask.ref.getDownloadURL().then((fileURL) {
          user = user.copyWith(
            avatar: fileURL,
          );
        });
      }

      await userDocument.update(user.toJson());

      return user;
    } catch (e) {
      throw ApiException(
        error: e.toString(),
      );
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      var currentUser = firebaseAuthProvider.currentUser;
      if (currentUser == null) {
        throw ApiException(
          code: 401,
          error: "failed_user_not_signed".tr,
        );
      }

      // Get user
      DocumentSnapshot foundUser = await firebaseFirestore
          .collection("users")
          .doc(currentUser.uid)
          .get();

      return UserModel.fromJson(foundUser.data());
    } catch (e) {
      throw ApiException(
        error: e.toString(),
      );
    }
  }
}
