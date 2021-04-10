import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/pages/conversations/conversations_binding.dart';
import 'package:testquick/app/presentation/pages/conversations/local_widgets/conversation_item.dart';

import 'conversations_controller.dart';

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
                Container(
                  margin: EdgeInsets.only(
                    top: 20.h,
                    bottom: 30.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Chats",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: 30.sp,
                            ),
                      ),
                      IconButton(
                        icon: Icon(
                          CupertinoIcons.search,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
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
