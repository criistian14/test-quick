import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/global_widgets/field_auth.dart';
import 'package:testquick/app/presentation/global_widgets/image_avatar.dart';

import '../edit_profile_controller.dart';

class FormEditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      id: "form",
      builder: (editProfileCtrl) => Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 30.h,
            ),
            child: ImageAvatar(
              user: editProfileCtrl.user,
              radius: 64.r,
              onTap: editProfileCtrl.changeAvatar,
            ),
          ),

          // First Name
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: FieldAuth(
              controller: editProfileCtrl.firstNameFieldCtrl,
              fieldFocusNode: editProfileCtrl.firstNameFocus,
              nextFieldFocusNode: editProfileCtrl.lastNameFocus,
              label: "first_name".tr,
              margin: EdgeInsets.only(
                top: 50.h,
              ),
              onChange: editProfileCtrl.changeFirstName,
              error: editProfileCtrl.firstName.invalid ?? false,
              errorText: editProfileCtrl.firstName.error,
            ),
          ),

          // Last Name
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: FieldAuth(
              controller: editProfileCtrl.lastNameFieldCtrl,
              fieldFocusNode: editProfileCtrl.lastNameFocus,
              label: "last_name".tr,
              margin: EdgeInsets.only(
                top: 30.h,
                bottom: 50.h,
              ),
              onChange: editProfileCtrl.changeLastName,
              error: editProfileCtrl.lastName.invalid ?? false,
              errorText: editProfileCtrl.lastName.error,
            ),
          ),

          _btnSubmit(
            editProfileCtrl: editProfileCtrl,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _btnSubmit({
    EditProfileController editProfileCtrl,
    BuildContext context,
  }) {
    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: ElevatedButton(
          onPressed: editProfileCtrl.updateUser,
          child: editProfileCtrl.loading.value
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).backgroundColor,
                  ),
                )
              : Text(
                  "update".tr,
                ),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).accentColor,
            padding: EdgeInsets.all(10.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
