import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import '../../../../../core/resource/app_size.dart';
import '../../../../../core/widget/text/app_text.dart';

class MostBannerWidget extends StatelessWidget {
  final String title, title1;
  final Function()? onTap;

  const MostBannerWidget(
      {super.key, this.onTap, required this.title, required this.title1});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: title.tr(),
          fontWeight: FontWeight.w500,
          fontSize: AppFontSize.sp16,
        ),
        InkWell(
          onTap: onTap,
          child: AppText(
            text: title1.tr(),
            fontWeight: FontWeight.w400,
            fontSize: AppFontSize.sp14,
            fontColor: AppColor.purple,
          ),
        ),
      ],
    );
  }
}
