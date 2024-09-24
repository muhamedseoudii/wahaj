import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';

import '../../resource/app_image.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/11/2024.
 */

class MainAppFooter extends StatelessWidget {
  const MainAppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.purple,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImage.newAppIconWhite,
                width: AppWidthSize.w50,
                height: AppHeightSize.h15,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Divider(
            color: AppColor.darkOrange,
            endIndent: AppWidthSize.w3point8,
            indent: AppWidthSize.w3point8,
          ),
          SizedBox(
            height: AppHeightSize.h1,
          ),
          AppText(
            text: "copyRight".tr(),
            fontColor: AppColor.white,
            fontSize: AppFontSize.sp15,
          ),
          SizedBox(
            height: AppHeightSize.h1,
          ),
        ],
      ),
    );
  }
}
