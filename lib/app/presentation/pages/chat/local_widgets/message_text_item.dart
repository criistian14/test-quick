import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:testquick/app/data/models/message_model.dart';

class MessageTextItem extends StatelessWidget {
  final MessageModel message;
  final bool isOwn;

  MessageTextItem({
    Key key,
    @required this.message,
    @required this.isOwn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          message.message,
          style: TextStyle(
            color: isOwn ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: .6,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(
          width: 9.w,
        ),
        Text(
          Jiffy(message.createdAt).format("h:mm a"),
          style: TextStyle(
            color: isOwn ? Colors.white : Colors.black,
            letterSpacing: 0.3,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        if (isOwn)
          SvgPicture.asset(
            "assets/icons/double-check.svg",
            height: 17.h,
            color: message.read ? Colors.white : Theme.of(context).shadowColor,
          ),
      ],
    );
  }
}
