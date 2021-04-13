import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testquick/app/core/errors/failures.dart';
import 'package:testquick/app/core/routes/app_routes.dart';

class Alerts {
  static errorAlertUseCase(Failure failure) {
    String messageError;

    if (failure is ServerFailure) {
      if (failure.code != null && failure.code == 401) {
        Get.offNamedUntil(AppRoutes.SIGN_IN, (route) => false);
      }

      messageError = failure.error;
    } else {
      messageError = failure.toString();
    }

    Get.snackbar(
      "Error: ",
      messageError,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
