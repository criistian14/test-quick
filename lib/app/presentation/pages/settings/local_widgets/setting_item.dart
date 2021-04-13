import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingItem extends StatelessWidget {
  final String text;
  final EdgeInsets margin;
  final Function onTap;
  final Widget rightWidget;

  SettingItem({
    Key key,
    this.margin,
    @required this.text,
    @required this.onTap,
    this.rightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      margin: margin,
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                if (rightWidget != null)
                  rightWidget
                else
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
