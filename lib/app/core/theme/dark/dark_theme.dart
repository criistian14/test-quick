import 'package:flutter/material.dart';

import '../constants_theme.dart';
import 'dark_text_theme.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: "Poppins",
  accentColor: ConstantsTheme.accentColor,
  backgroundColor: Color(0xFF102E4A),
  scaffoldBackgroundColor: Color(0xFF2E2E2E),
  textTheme: darkTextTheme,
  bottomNavigationBarTheme: _bottomNavigationBar,
  appBarTheme: _appBarTheme,
  shadowColor: ConstantsTheme.greyLightColor,
);

BottomNavigationBarThemeData _bottomNavigationBar =
    BottomNavigationBarThemeData(
  backgroundColor: Color(0xFF0B0E11),
  selectedItemColor: ConstantsTheme.accentColor,
  unselectedItemColor: Colors.blueGrey[200],
);

AppBarTheme _appBarTheme = AppBarTheme(
  backgroundColor: Color(0xFF102E4A),
  titleTextStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
  ),
  actionsIconTheme: IconThemeData(
    color: Colors.white,
  ),
  iconTheme: IconThemeData(
    color: Colors.blueGrey[200],
  ),
);
