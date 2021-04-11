import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:testquick/app/data/models/conversation_model.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/presentation/global_widgets/image_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../conversations_controller.dart';

class ConversationItem extends StatelessWidget {
  final ConversationModel conversation;
  final ConversationsController _conversationsCtrl =
      Get.find<ConversationsController>();

  ConversationItem({
    Key key,
    @required this.conversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userReceiver = conversation.users[0];

    if (conversation.meUid != conversation.users[1].uid) {
      userReceiver = conversation.users[1];
    }

    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      margin: EdgeInsets.only(
        bottom: 13.h,
      ),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () => _conversationsCtrl.goChat(
            user: userReceiver,
          ),
          child: Row(
            children: [
              ImageAvatar(
                user: userReceiver,
                radius: 30.r,
              ),
              Container(
                width: 260.w,
                height: 60.h,
                margin: EdgeInsets.only(
                  left: 12.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _informationTop(
                      context: context,
                      user: userReceiver,
                    ),
                    _informationBottom(
                      context: context,
                      user: userReceiver,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _informationTop({
    BuildContext context,
    UserModel user,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 220.w,
          child: Text(
            "${user.firstName} ${user.lastName}",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontSize: 20.sp,
                ),
          ),
        ),
        if (conversation.lastMessage.createdAt != null)
          Text(
            timeago.format(
              conversation.lastMessage.createdAt,
              locale: "en_short",
            ),
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 15.sp,
                ),
          ),
      ],
    );
  }

  Widget _informationBottom({
    BuildContext context,
    UserModel user,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 240.w,
          child: Text(
            conversation.lastMessage.message,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 16.sp,
                ),
          ),
        ),

        // Notify that there are unread messages
        if (!conversation.lastMessage.read &&
            conversation.meUid != conversation.lastMessage.idFrom)
          Container(
            width: 12.r,
            height: 12.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).accentColor,
            ),
          ),
      ],
    );
  }
}
