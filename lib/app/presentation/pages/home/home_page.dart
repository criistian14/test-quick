import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        body: Center(
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
      ),
    );
  }
}
