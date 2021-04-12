import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../chat_controller.dart';

class ChatField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      id: "field",
      builder: (chatCtrl) => Container(
        constraints: BoxConstraints(
          minHeight: 80.h,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: Offset(0, 8),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textField(
                  context: context,
                  chatCtrl: chatCtrl,
                ),
                _btnSubmit(
                  context: context,
                  chatCtrl: chatCtrl,
                ),
              ],
            ),
            _emojiPicker(
              context: context,
              chatCtrl: chatCtrl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    BuildContext context,
    ChatController chatCtrl,
  }) {
    Widget prefixIcon = IconButton(
      onPressed: chatCtrl.changeStateEmojiContainer,
      color: Colors.blueGrey.withOpacity(0.8),
      icon: Icon(
        Icons.emoji_emotions_outlined,
      ),
    );

    if (chatCtrl.soundRecorderStarted) {
      prefixIcon = null;
    }

    Widget suffixIcon = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: chatCtrl.sendPicture,
          color: Colors.blueGrey.withOpacity(0.8),
          icon: Icon(
            CupertinoIcons.camera,
          ),
        ),
      ],
    );

    if (!chatCtrl.isEmptyField()) {
      suffixIcon = null;
    }

    return Container(
      width: 299.w,
      child: TextFormField(
        onChanged: chatCtrl.changeMessage,
        onTap: chatCtrl.hiddenEmojiContainer,
        controller: chatCtrl.messageFieldCtrl,
        focusNode: chatCtrl.messageFocus,
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        minLines: 1,
        decoration: InputDecoration(
          hintText: "Type a message",
          isDense: true,
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 14.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _btnSubmit({
    BuildContext context,
    ChatController chatCtrl,
  }) {
    return Material(
      shape: CircleBorder(),
      color: chatCtrl.soundRecorderStarted
          ? Colors.red
          : Theme.of(context).appBarTheme.backgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(30.r),
        onTap: () {},
        child: GestureDetector(
          onTap: chatCtrl.sendText,
          onLongPress: chatCtrl.startRecordVoiceNote,
          onLongPressUp: chatCtrl.sendVoiceNote,
          child: Container(
            padding: EdgeInsets.all(12.r),
            child: Icon(
              _iconSubmit(
                context: context,
                chatCtrl: chatCtrl,
              ),
              color: chatCtrl.soundRecorderStarted
                  ? Colors.white
                  : Colors.blueGrey.withOpacity(0.8),
              size: chatCtrl.soundRecorderStarted ? 55.r : null,
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconSubmit({
    BuildContext context,
    ChatController chatCtrl,
  }) {
    if (chatCtrl.isEmptyField()) {
      return Icons.mic;
    }

    if (chatCtrl.soundRecorderStarted) {
      return Icons.mic;
    }

    return Icons.send;
  }

  Widget _emojiPicker({
    BuildContext context,
    ChatController chatCtrl,
  }) {
    return Offstage(
      offstage: !chatCtrl.emojiShowing,
      child: SizedBox(
        height: 250,
        child: EmojiPicker(
          onEmojiSelected: (category, emoji) {
            String message = chatCtrl.messageFieldCtrl.text;
            message += emoji.emoji;
            chatCtrl.messageFieldCtrl.text = message;

            chatCtrl.changeMessage(message);
          },
          config: Config(
            bgColor: Theme.of(context).backgroundColor,
            indicatorColor: Theme.of(context).accentColor,
            iconColorSelected: Theme.of(context).accentColor,
            columns: 7,
            emojiSizeMax: 32,
          ),
        ),
      ),
    );
  }
}
