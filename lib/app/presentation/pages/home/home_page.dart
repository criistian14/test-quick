import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/global_widgets/bottom_navigation.dart';
import 'package:testquick/app/presentation/pages/conversations/conversations_page.dart';
import 'package:testquick/app/presentation/pages/contacts/contacts_page.dart';
import 'package:testquick/app/presentation/pages/settings/settings_page.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PageView(
          controller: _homeCtrl.pageCtrl.value,
          onPageChanged: (index) {
            _homeCtrl.page.value = index;
          },
          children: [
            ConversationsPage(),
            ContactsPage(),
            SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
