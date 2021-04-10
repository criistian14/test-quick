import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:testquick/app/presentation/pages/home/home_controller.dart';

class BottomNavigation extends StatelessWidget {
  final HomeController _homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: _homeCtrl.page.value,
        onTap: _homeCtrl.changePage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                bottom: 4.h,
                top: 6.h,
              ),
              child: SvgPicture.asset(
                "assets/icons/chat-bubble.svg",
                width: 17.w,
                color: _getColor(
                  context: context,
                  index: 0,
                ),
              ),
            ),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                bottom: 4.h,
                top: 6.h,
              ),
              child: SvgPicture.asset(
                "assets/icons/user-group.svg",
                width: 17.w,
                color: _getColor(
                  context: context,
                  index: 1,
                ),
              ),
            ),
            label: "contacts".tr,
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(
                bottom: 4.h,
                top: 6.h,
              ),
              child: SvgPicture.asset(
                "assets/icons/settings.svg",
                width: 17.w,
                color: _getColor(
                  context: context,
                  index: 2,
                ),
              ),
            ),
            label: "settings".tr,
          ),
        ],
      ),
    );
  }

  Color _getColor({
    BuildContext context,
    int index,
  }) {
    if (_homeCtrl.page.value == index) {
      return Theme.of(context).accentColor;
    }

    return Theme.of(context).bottomNavigationBarTheme.unselectedItemColor;
  }
}
