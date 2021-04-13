import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/pages/sign_in/local_widgets/form_sign_in.dart';

import 'sign_in_controller.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      builder: (signInCtrl) => Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 270.w,
                    margin: EdgeInsets.only(
                      top: 50.h,
                    ),
                    child: Text(
                      "welcome".tr,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            height: 1.2,
                            fontSize: 40.sp,
                          ),
                    ),
                  ),
                  FormSignIn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
