import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'local_widgets/setting_item.dart';
import 'settings_binding.dart';
import 'settings_controller.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsBinding().dependencies();

    return GetBuilder<SettingsController>(
      builder: (settingsCtrl) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Column(
                  children: [
                    SettingItem(
                      text: "edit_profile_information".tr,
                      onTap: settingsCtrl.goEditProfile,
                      margin: EdgeInsets.only(
                        top: 40.h,
                      ),
                    ),
                    SettingItem(
                      text: "dark_mode".tr,
                      onTap: settingsCtrl.changeTheme,
                      margin: EdgeInsets.only(
                        top: 20.h,
                      ),
                      rightWidget: Container(
                        height: ScreenUtil().setHeight(7),
                        child: Switch(
                          value: Get.isDarkMode,
                          activeColor: Theme.of(context).accentColor,
                          onChanged: (value) {
                            settingsCtrl.changeTheme();
                          },
                        ),
                      ),
                    ),
                    SettingItem(
                      text: "language".tr,
                      onTap: settingsCtrl.changeLanguage,
                      margin: EdgeInsets.only(
                        top: 20.h,
                        bottom: 10.h,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: 30.h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: ElevatedButton(
                  onPressed: settingsCtrl.signOut,
                  child: Text(
                    "sign_out".tr,
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
            ],
          ),
        ),
      ),
    );
  }
}
