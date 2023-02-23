import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Ubuntu',
  primaryColor: Color(0xFF0461A5),
  primaryColorLight: Color(0xFF0461A5),
  primaryColorDark: Color(0xFF10324A),
  scaffoldBackgroundColor: Color(0xFFF7F9FC),
  backgroundColor: Color(0xFFF7F9FC),
  cardColor: Color(0xFFFFFFFF),

  shadowColor: Color(0xFFD1D5DB),
  canvasColor: Color(0xFF033969),

  secondaryHeaderColor: Color(0xFF8797AB),
  disabledColor: Color(0xFF9E9E9E),

  errorColor: Color(0xFFFF6767),
  brightness: Brightness.light,
  hintColor: Color(0xFF838383),
  focusColor: Color(0xFFFEFEFE),
  hoverColor: Color(0xFF033969),

  timePickerTheme: TimePickerThemeData(
      hourMinuteTextColor: Color(0xFF10324a)
  ),

  colorScheme: ColorScheme.light(
      primary: Color(0xFF0461A5),
      onPrimary: Color(0xffeef1ef),
      onSecondary: Color(0xff2A45D3),
      secondary: Color(0xff3979E1),
      tertiary: Color(0xffF58F2A)),
);