import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_icon.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/text/app_text.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/11/2024.
 */

class PrimaryInfo extends StatelessWidget {
  const PrimaryInfo({super.key,required this.info});

  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
      padding: EdgeInsets.symmetric(
          horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColor.lightGrey, blurRadius: 25, offset: const Offset(1, 9))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColor.darkOrange,
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(
                horizontal: AppWidthSize.w3point8,
                vertical: AppHeightSize.h1point8),
            child: SvgPicture.asset(
              AppIcon.info,
              width: 32.px,
              height: 32.px,
              colorFilter: ColorFilter.mode(AppColor.white, BlendMode.srcIn),
            ),
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          AppText(
            text: "whoWeAre".tr(),
            fontColor: AppColor.purple,
            fontWeight: FontWeight.w600,
            fontSize: AppFontSize.sp16,
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          AppText(
            text: info,
            fontColor: AppColor.grey,
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.sp15,
          ),
        ],
      ),
    );
  }
}
