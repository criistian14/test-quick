import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/pages/chat/local_widgets/chat_item.dart';
import 'package:testquick/app/presentation/pages/chat/local_widgets/field_chat.dart';

import 'chat_controller.dart';
import 'local_widgets/app_bar_chat.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (chatCtrl) => Scaffold(
        appBar: AppBarChat(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Obx(() {
                      if (chatCtrl.loading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (chatCtrl.messagesList.isEmpty) {
                        return Center(
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 130.h,
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: chatCtrl.messagesList.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.w,
                          vertical: 18.h,
                        ),
                        reverse: true,
                        itemBuilder: (context, index) => ChatItem(
                          message: chatCtrl.messagesList[index],
                          isOwn: chatCtrl.messagesList[index].idFrom !=
                              chatCtrl.contact.uid,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              ChatField(),
            ],
          ),
        ),
      ),
    );
  }
}
