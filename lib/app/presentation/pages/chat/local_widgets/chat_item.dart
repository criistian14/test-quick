import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testquick/app/data/models/message_model.dart';

import 'message_audio_item.dart';
import 'message_picture_item.dart';
import 'message_text_item.dart';

class ChatItem extends StatelessWidget {
  final MessageModel message;
  final bool isOwn;

  ChatItem({
    Key key,
    this.message,
    this.isOwn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isOwn ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 250.w,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 14.h,
          ),
          margin: EdgeInsets.only(
            top: 18.h,
          ),
          decoration: BoxDecoration(
            color: isOwn
                ? Theme.of(context).accentColor
                : Colors.blueGrey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: _messageContent(
            context: context,
          ),
        )
      ],
    );
  }

  Widget _messageContent({
    BuildContext context,
  }) {
    if (message.picture != null) {
      return MessagePictureItem(
        message: message,
        isOwn: isOwn,
      );
    }

    if (message.audio != null) {
      return MessageAudioItem(
        message: message,
        isOwn: isOwn,
      );
    }

    return MessageTextItem(
      message: message,
      isOwn: isOwn,
    );
  }
}
