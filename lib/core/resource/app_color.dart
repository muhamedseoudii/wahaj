import 'dart:ui';

import 'package:flutter/material.dart';

/**
 * Created by Eng.Eyad AlSayed on 4/23/2024.
 */

abstract class AppColor {
  static const Color purple = Color(0xff5605ba);
  static const Color darkPurple = Color(0xff40038f);
  static const Color navy = Color(0xff100123);
  static const Color darkOrange = Color(0xffe44906);
  static const Color orange = Color(0xffFF751A);
  static const Color rose = Color(0xfffff4ee);
  static const Color green = Colors.green;
  static const Color lightGreen = Color(0xffcdf8cf);
  static const Color grey = Colors.grey;
  static const Color grey1 = Color(0xffE5E5EA);
  static const Color grey2 = Color(0xff8E8E93);

  static Color lightGrey = Colors.grey[350] ?? Colors.grey;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color background = Colors.white;
  static const Color red = Colors.red;
  static Color darkRed = Colors.red[700] ?? red;
}

abstract class AppGradient {
  static const darkOrangePurpleTopBottom = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColor.darkOrange,
        AppColor.purple,
      ]);
  static const darkOrangePurpleTopLeftBottomRight = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColor.darkOrange,
        AppColor.darkOrange,
        AppColor.purple,
        AppColor.purple,
      ]);
}
