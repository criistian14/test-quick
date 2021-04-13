import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/global_widgets/image_avatar.dart';
import 'package:testquick/app/presentation/pages/chat/chat_controller.dart';

class AppBarChat extends StatelessWidget implements PreferredSizeWidget {
  final double height = 70.h;

  @override
  Size get preferredSize => Size.fromHeight(height);

  final ChatController _chatCtrl = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          CupertinoIcons.back,
        ),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          ImageAvatar(
            user: _chatCtrl.contact,
            radius: 24.r,
          ),
          SizedBox(
            width: 7.w,
          ),
          Text(
            "${_chatCtrl.contact.firstName} ${_chatCtrl.contact.lastName}",
            style: Theme.of(context).appBarTheme.titleTextStyle.copyWith(
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }
}
