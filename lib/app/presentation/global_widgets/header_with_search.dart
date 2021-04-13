import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWithSearch extends StatelessWidget {
  final String title;
  final Function onSearch;

  HeaderWithSearch({
    Key key,
    @required this.title,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.h,
        bottom: 30.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: 30.sp,
                ),
          ),
          IconButton(
            icon: Icon(
              CupertinoIcons.search,
            ),
            onPressed: onSearch,
          ),
        ],
      ),
    );
  }
}
