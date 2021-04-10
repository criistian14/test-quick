import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testquick/app/data/models/user_model.dart';
import 'package:testquick/app/domain/entities/conversation.dart';
import 'package:testquick/app/presentation/pages/conversations/conversations_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

class ConversationItem extends StatelessWidget {
  final Conversation conversation;
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
            conversation: conversation,
          ),
          child: Row(
            children: [
              _imgAvatar(
                context: context,
                user: userReceiver,
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

  Widget _imgAvatar({
    BuildContext context,
    UserModel user,
  }) {
    return CircleAvatar(
      child: Text(
        user.firstName[0],
        style: Theme.of(context).textTheme.headline5.copyWith(
              color: Colors.white,
            ),
      ),
      foregroundImage: (user.avatar != null) ? NetworkImage(user.avatar) : null,
      backgroundColor: Theme.of(context).accentColor,
      radius: 30.r,
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
        Text(
          "${user.firstName} ${user.lastName}",
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontSize: 20.sp,
              ),
        ),
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
        if (!conversation.lastMessage.read)
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
