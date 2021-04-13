import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/pages/edit_profile/local_widgets/form_edit_profile.dart';

import 'edit_profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (editProfileCtrl) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              CupertinoIcons.back,
            ),
          ),
          title: Text(
            "edit_profile_information".tr,
            style: Theme.of(context).appBarTheme.titleTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
          ),
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FormEditProfile(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
