import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/global_widgets/header_with_search.dart';

import 'conversations_binding.dart';
import 'conversations_controller.dart';
import 'local_widgets/conversation_item.dart';

class ConversationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConversationsBinding().dependencies();

    return GetBuilder<ConversationsController>(
      builder: (conversationsCtrl) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderWithSearch(
                  title: "Chats",
                  onSearch: () {},
                ),

                // Conversations List
                Obx(() {
                  if (conversationsCtrl.loading.value) {
                    return CircularProgressIndicator();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: conversationsCtrl.conversationsList.length,
                    itemBuilder: (context, index) => ConversationItem(
                      conversation: conversationsCtrl.conversationsList[index],
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
