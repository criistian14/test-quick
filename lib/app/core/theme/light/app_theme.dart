import 'package:flutter/material.dart';

import '../constants_theme.dart';
import 'text_theme.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: "Poppins",
  accentColor: ConstantsTheme.accentColor,
  textTheme: textTheme,
);
