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
);

BottomNavigationBarThemeData _bottomNavigationBar =
    BottomNavigationBarThemeData(
  backgroundColor: ConstantsTheme.pureWitheColor,
  selectedItemColor: ConstantsTheme.accentColor,
  unselectedItemColor: ConstantsTheme.greyLightColor,
);
