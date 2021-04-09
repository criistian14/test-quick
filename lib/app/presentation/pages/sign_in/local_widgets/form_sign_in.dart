import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testquick/app/presentation/global_widgets/field_auth.dart';
import 'package:testquick/app/presentation/pages/sign_in/sign_in_controller.dart';

class FormSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      id: "form",
      builder: (signInCtrl) => Column(
        children: [
          _emailField(
            signInCtrl: signInCtrl,
            context: context,
          ),
          _passwordField(
            signInCtrl: signInCtrl,
            context: context,
          ),
          SizedBox(
            height: 60.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "sign_in".tr,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: 22.sp,
                    ),
              ),
              _btnSubmit(
                signInCtrl: signInCtrl,
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emailField({
    SignInController signInCtrl,
    BuildContext context,
  }) {
    return FieldAuth(
      fieldFocusNode: signInCtrl.emailFocus,
      nextFieldFocusNode: signInCtrl.passwordFocus,
      label: "email".tr,
      type: TextInputType.emailAddress,
      margin: EdgeInsets.only(
        top: 60.h,
      ),
      onChange: signInCtrl.changeEmail,
      error: signInCtrl.email.invalid ?? false,
      errorText: signInCtrl.email.error,
    );
  }

  Widget _passwordField({
    SignInController signInCtrl,
    BuildContext context,
  }) {
    return FieldAuth(
      fieldFocusNode: signInCtrl.passwordFocus,
      label: "password".tr,
      type: TextInputType.visiblePassword,
      isPassword: true,
      margin: EdgeInsets.only(
        top: 30.h,
      ),
      onChange: signInCtrl.changePassword,
      error: signInCtrl.password.invalid ?? false,
      errorText: signInCtrl.password.error,
    );
  }

  Widget _btnSubmit({
    SignInController signInCtrl,
    BuildContext context,
  }) {
    return Obx(
      () => ElevatedButton(
        onPressed: signInCtrl.signIn,
        child: signInCtrl.loading.value
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).backgroundColor,
                ),
              )
            : Icon(
                Icons.arrow_forward_ios_rounded,
              ),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          padding: EdgeInsets.all(20.w),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
