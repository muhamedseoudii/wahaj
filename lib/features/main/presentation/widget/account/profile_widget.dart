import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:ui' as ui;
import '../../../../../core/resource/app_size.dart';
import '../../../../../core/widget/text/app_text.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          padding: EdgeInsets.all(AppWidthSize.w2),
          child: SvgPicture.asset(
            AppIcon.userCircle,
            width: 50.px,
            height: 50.px,
          ),
        ),
        SizedBox(
          width: AppWidthSize.w3,
        ),
        Directionality(
          textDirection: ui.TextDirection.ltr,
          child: AppText(
            text: AppSharedPreferences.getUserName(),
            fontSize: AppFontSize.sp17,
            fontWeight: FontWeight.w400,
            fontColor: AppColor.navy,
          ),
        ),
      ],
    );
  }
}
