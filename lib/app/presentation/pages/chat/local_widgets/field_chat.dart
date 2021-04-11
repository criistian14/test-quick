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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 299.w,
              child: TextFormField(
                onChanged: chatCtrl.changeMessage,
                controller: chatCtrl.messageFieldCtrl,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "Type a message",
                  isDense: true,
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  prefixIcon: chatCtrl.isEmptyField()
                      ? IconButton(
                          onPressed: () {
                            print("Record Audio");
                          },
                          color: Colors.blueGrey.withOpacity(0.8),
                          icon: Icon(
                            Icons.mic,
                          ),
                        )
                      : null,
                  suffixIcon: chatCtrl.isEmptyField()
                      ? IconButton(
                          onPressed: () {
                            print("Camera");
                          },
                          color: Colors.blueGrey.withOpacity(0.8),
                          icon: Icon(
                            CupertinoIcons.camera,
                          ),
                        )
                      : null,
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
            ),
            Material(
              shape: CircleBorder(),
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: InkWell(
                borderRadius: BorderRadius.circular(30.r),
                onTap: chatCtrl.sendMessage,
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  child: Icon(
                    Icons.send,
                    color: Colors.blueGrey.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
