import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/pages/contacts/contacts_binding.dart';

import 'contacts_controller.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactsBinding().dependencies();

    return GetBuilder<ContactsController>(
      builder: (contactsCtrl) => Scaffold(
        body: Center(
          child: Text("Contacts"),
        ),
      ),
    );
  }
}
