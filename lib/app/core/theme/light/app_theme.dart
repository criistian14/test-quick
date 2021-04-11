import 'package:flutter/material.dart';

import '../constants_theme.dart';
import 'text_theme.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: "Poppins",
  accentColor: ConstantsTheme.accentColor,
  backgroundColor: ConstantsTheme.pureWitheColor,
  scaffoldBackgroundColor: ConstantsTheme.backgroundColor,
  textTheme: textTheme,
  bottomNavigationBarTheme: _bottomNavigationBar,
  appBarTheme: _appBarTheme,
  shadowColor: ConstantsTheme.greyLightColor,
);

BottomNavigationBarThemeData _bottomNavigationBar =
    BottomNavigationBarThemeData(
  backgroundColor: ConstantsTheme.pureWitheColor,
  selectedItemColor: ConstantsTheme.accentColor,
  unselectedItemColor: ConstantsTheme.greyLightColor,
);

AppBarTheme _appBarTheme = AppBarTheme(
  backgroundColor: ConstantsTheme.pureWitheColor,
  titleTextStyle: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
  ),
  actionsIconTheme: IconThemeData(
    color: Colors.black,
  ),
  iconTheme: IconThemeData(
    color: Colors.blueGrey,
  ),
);
