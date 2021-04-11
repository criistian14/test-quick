import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/global_widgets/header_with_search.dart';

import 'contacts_binding.dart';
import 'contacts_controller.dart';
import 'local_widgets/contact_item.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactsBinding().dependencies();

    return GetBuilder<ContactsController>(
      builder: (contactsCtrl) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderWithSearch(
                  title: "contacts".tr,
                  onSearch: () {},
                ),

                // Contacts List
                Obx(() {
                  if (contactsCtrl.loading.value) {
                    return CircularProgressIndicator();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactsCtrl.contactsList.length,
                    itemBuilder: (context, index) => ContactItem(
                      contact: contactsCtrl.contactsList[index],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
