import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:testquick/app/data/models/message_model.dart';

class MessageAudioItem extends StatelessWidget {
  final MessageModel message;
  final bool isOwn;

  MessageAudioItem({
    Key key,
    @required this.message,
    @required this.isOwn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 50.h,
          child: SoundPlayerUI.fromLoader(
            (context) async {
              Track track = Track(
                trackPath: message.audio,
                codec: Codec.aacMP4,
              );

              return track;
            },
            showTitle: false,
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
