import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import '../../resource/app_color.dart';
import '../../resource/app_icon.dart';
import '../text/app_text.dart';

abstract class NoteMessage {
  static showErrorSnackBar({
    required BuildContext context,
    required String text,
    void Function()? onTap,
    int? duration,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: AppWidthSize.w100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AppText(
                  text: text,
                  fontSize: AppFontSize.sp14,
                  fontColor: AppColor.red,
                  fontWeight: FontWeight.bold,
                  maxLines: maxLines ?? 2,
                ),
              ),
              SizedBox(
                width: AppWidthSize.w2,
              ),
              GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: SvgPicture.asset(AppIcon.warning,
                      colorFilter: const ColorFilter.mode(
                          AppColor.red, BlendMode.srcIn)))
            ],
          ),
        ),
      ),
      backgroundColor: AppColor.white,
      duration: Duration(seconds: duration ?? 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(width: 2, color: AppColor.red),
      ),
    ));
  }

  static showSuccessSnackBar({
    required BuildContext context,
    required String text,
    void Function()? onTap,
    int? duration,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: AppWidthSize.w100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AppText(
                  text: text,
                  fontSize: AppFontSize.sp14,
                  fontColor: AppColor.green,
                  fontWeight: FontWeight.bold,
                  maxLines: maxLines ?? 2,
                ),
              ),
              SizedBox(
                width: AppWidthSize.w2,
              ),
              GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: SvgPicture.asset(AppIcon.done,
                      colorFilter: const ColorFilter.mode(
                          AppColor.green, BlendMode.srcIn)))
            ],
          ),
        ),
      ),
      backgroundColor: AppColor.white,
      duration: Duration(seconds: duration ?? 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(width: 2, color: AppColor.green),
      ),
    ));
  }
}
