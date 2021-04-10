import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var page = 0.obs;
  var pageCtrl = PageController(initialPage: 0).obs;

  void changePage(int index) {
    page.value = index;
    pageCtrl.value.jumpToPage(index);
  }
}
