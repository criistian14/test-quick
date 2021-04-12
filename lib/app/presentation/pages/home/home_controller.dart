import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  var page = 0.obs;
  var pageCtrl = PageController(initialPage: 0).obs;

  @override
  void onReady() async {
    super.onReady();

    _requestPermissions();
  }

  void changePage(int index) {
    page.value = index;
    pageCtrl.value.jumpToPage(index);
  }

  void _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.microphone,
    ].request();

    bool allowAllPermissions = true;
    bool permissionPermanentlyDenied = false;

    statuses.forEach((key, value) {
      if (value.isDenied) {
        allowAllPermissions = false;
      }

      if (value.isPermanentlyDenied) {
        permissionPermanentlyDenied = true;
      }
    });

    if (!allowAllPermissions || permissionPermanentlyDenied) {
      Get.defaultDialog(
        title: "permissions_must_enabled".tr,
        content: ElevatedButton(
          onPressed: () => Get.back(),
          child: Text("OK"),
        ),
      ).then((value) async {
        _requestPermissions();
      });

      if (permissionPermanentlyDenied) {
        openAppSettings();
      }
    }
  }
}
