import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ModalsUtils {
  static Future<ImageSource> pickSourceImage() {
    return Get.bottomSheet(Container(
      height: 200,
      color: Get.theme.backgroundColor,
      padding: EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        children: [
          Text(
            "pick_source_image".tr,
            style: Get.textTheme.headline5,
          ),
          SizedBox(
            height: 30,
          ),
          Material(
            color: Get.theme.backgroundColor,
            child: InkWell(
              onTap: () => Get.back(result: ImageSource.gallery),
              child: ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("gallery".tr),
              ),
            ),
          ),
          Material(
            color: Get.theme.backgroundColor,
            child: InkWell(
              onTap: () => Get.back(result: ImageSource.camera),
              child: ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("camera".tr),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
