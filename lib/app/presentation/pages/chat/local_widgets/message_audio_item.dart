import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:testquick/app/data/models/message_model.dart';

class MessageAudioItem extends StatefulWidget {
  final MessageModel message;
  final bool isOwn;

  MessageAudioItem({
    Key key,
    @required this.message,
    @required this.isOwn,
  }) : super(key: key);

  @override
  _MessageAudioItemState createState() => _MessageAudioItemState();
}

class _MessageAudioItemState extends State<MessageAudioItem> {
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
                trackPath: widget.message.audio,
                codec: Codec.aacMP4,
              );

              print(track.trackPath);

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
              Jiffy(widget.message.createdAt).format("h:mm a"),
              style: TextStyle(
                color: widget.isOwn ? Colors.white : Colors.black,
                letterSpacing: 0.3,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            if (widget.isOwn)
              SvgPicture.asset(
                "assets/icons/double-check.svg",
                height: 17.h,
                color: widget.message.read
                    ? Colors.white
                    : Theme.of(context).shadowColor,
              ),
          ],
        ),
      ],
    );
  }
}
