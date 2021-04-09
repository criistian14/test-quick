import 'package:flutter/material.dart';

import '../constants_theme.dart';
import 'dark_text_theme.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: "Poppins",
  accentColor: ConstantsTheme.accentColor,
  textTheme: darkTextTheme,
);
