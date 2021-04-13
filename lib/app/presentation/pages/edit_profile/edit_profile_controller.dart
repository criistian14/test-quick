import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:testquick/app/core/usecases/usecase.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/core/utils/modals.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/entities/form/first_name_form.dart';
import 'package:testquick/app/domain/entities/form/last_name_form.dart';
import 'package:testquick/app/domain/usecases/get_current_user.dart';
import 'package:testquick/app/domain/usecases/update_user.dart';

class EditProfileController extends GetxController {
  final GetCurrentUser _getCurrentUser;
  final UpdateUser _updateUser;

  UserModel user;

  TextEditingController firstNameFieldCtrl = TextEditingController();
  TextEditingController lastNameFieldCtrl = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();

  FirstNameForm firstName = FirstNameForm.pure();
  LastNameForm lastName = LastNameForm.pure();
  RxBool loading = false.obs;

  ImagePicker imagePicker = ImagePicker();

  EditProfileController({
    @required GetCurrentUser getCurrentUser,
    @required UpdateUser updateUser,
  })  : assert(getCurrentUser != null),
        assert(updateUser != null),
        _getCurrentUser = getCurrentUser,
        _updateUser = updateUser;

  @override
  void onReady() async {
    super.onReady();

    var getCurrentUserCall = await _getCurrentUser.call(NoParams());
    getCurrentUserCall.fold(Alerts.errorAlertUseCase, (r) {
      user = r;
      this.firstName = FirstNameForm.dirty(r.firstName);
      this.lastName = LastNameForm.dirty(r.lastName);

      this.firstNameFieldCtrl.text = r.firstName;
      this.lastNameFieldCtrl.text = r.lastName;

      update();
    });
  }

  // * Change value inputs
  void changeFirstName(String value) {
    this.firstName = FirstNameForm.dirty(value);
    update(['form']);
  }

  void changeLastName(String value) {
    this.lastName = LastNameForm.dirty(value);
    update(['form']);
  }

  void changeAvatar() async {
    ImageSource source = await ModalsUtils.pickSourceImage();
    if (source == null) return;

    final pickedFile = await imagePicker.getImage(source: source);
    if (pickedFile == null) return;

    user = user.copyWith(
      avatarFile: File(pickedFile.path),
    );
    update(['form']);
  }

  // * Update User
  void updateUser() async {
    FormzStatus formStatus = Formz.validate([
      this.firstName,
      this.lastName,
    ]);
    if (formStatus.isInvalid) {
      return;
    }

    loading.value = true;

    UserModel userUpdate = user.copyWith(
      firstName: firstName.value,
      lastName: lastName.value,
    );

    var updateUserCall = await _updateUser.call(userUpdate);
    updateUserCall.fold(Alerts.errorAlertUseCase, (r) {
      user = r;
      loading.value = false;
    });
  }
}
