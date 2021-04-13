import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:testquick/app/core/routes/app_routes.dart';
import 'package:testquick/app/core/utils/alerts.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/entities/form/email_form.dart';
import 'package:testquick/app/domain/entities/form/password_form.dart';
import 'package:testquick/app/domain/usecases/sign_in_email_password.dart';

class SignInController extends GetxController {
  final SignInEmailPassword _signInEmailPassword;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  EmailForm email = EmailForm.pure();
  PasswordForm password = PasswordForm.pure();
  RxBool loading = false.obs;

  SignInController({
    @required SignInEmailPassword signInEmailPassword,
  })  : assert(signInEmailPassword != null),
        _signInEmailPassword = signInEmailPassword;

  @override
  void onInit() {
    super.onInit();

    // * Refresh fields label
    emailFocus.addListener(() {
      update(["form"]);
    });
    passwordFocus.addListener(() {
      update(["form"]);
    });
  }

  // * Change values
  void changeEmail(String email) {
    this.email = EmailForm.dirty(email);
    update(['form']);
  }

  void changePassword(String password) {
    this.password = PasswordForm.dirty(password);
    update(['form']);
  }

  // * Sign In
  void signIn() async {
    FormzStatus formStatus = Formz.validate([this.email, this.password]);
    if (formStatus.isInvalid || formStatus.isPure) {
      return;
    }

    this.loading.value = true;
    UserModel user = UserModel(
      email: email.value,
      password: password.value,
    );

    var signInCall = await _signInEmailPassword.call(user);
    signInCall.fold(Alerts.errorAlertUseCase, (r) {
      Get.offNamedUntil(AppRoutes.HOME, (route) => false);
    });

    this.loading.value = false;
  }

  @override
  void onClose() {
    emailFocus.dispose();
    passwordFocus.dispose();

    super.onClose();
  }
}
