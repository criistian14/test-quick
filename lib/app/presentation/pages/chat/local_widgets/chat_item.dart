import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:testquick/app/data/models/message_model.dart';

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
      return _messageIsPicture(
        context: context,
      );
    }

    return _messageIsText(
      context: context,
    );
  }

  Widget _messageIsText({
    BuildContext context,
  }) {
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

  Widget _messageIsPicture({
    BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 210.h,
          child: Image.network(
            message.picture,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).backgroundColor,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 9.h,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                color:
                    message.read ? Colors.white : Theme.of(context).shadowColor,
              ),
          ],
        ),
      ],
    );
  }
}
