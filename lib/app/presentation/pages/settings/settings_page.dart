import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/pages/settings/settings_binding.dart';

import 'settings_controller.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsBinding().dependencies();

    return GetBuilder<SettingsController>(
      builder: (settingsCtrl) => Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: settingsCtrl.signOut,
            child: Text(
              "sign_out".tr,
            ),
          ),
        ),
      ),
    );
  }
}
