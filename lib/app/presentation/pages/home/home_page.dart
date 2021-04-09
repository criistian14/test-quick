import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeCtrl) => Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: homeCtrl.signOut,
            child: Text("sign_out".tr),
          ),
        ),
      ),
    );
  }
}
