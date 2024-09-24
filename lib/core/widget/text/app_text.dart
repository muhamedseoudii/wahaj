import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_font_family.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/11/2024.
 */

class AppText extends StatelessWidget {
  const AppText(
      {super.key,
      required this.text,
      this.fontSize,
      this.height,
      this.fontColor,
      this.textDecoration,
      this.maxLines,
      this.textAlign,
      this.fontWeight,
      this.textOverflow});

  final String text;
  final double? fontSize, height;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final TextDecoration? textDecoration;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: LanguageHelper.isEnglishData(data: text)
          ? GoogleFonts.ibmPlexSans(
              textStyle: TextStyle(height: height),
              fontSize: fontSize ?? AppFontSize.sp14,
              fontWeight: fontWeight ?? FontWeight.w500,
              decoration: textDecoration,
              decorationColor: fontColor,
              color: fontColor ?? AppColor.black)
          : GoogleFonts.ibmPlexSansArabic(
              textStyle: TextStyle(height: height),
              fontSize: fontSize ?? AppFontSize.sp14,
              fontWeight: fontWeight ?? FontWeight.w500,
              decoration: textDecoration,
              decorationColor: fontColor,
              color: fontColor ?? AppColor.black),
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
