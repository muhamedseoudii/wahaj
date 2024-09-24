import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/text/app_text.dart';

class SecondaryInfo extends StatelessWidget {
  const SecondaryInfo(
      {super.key, required this.title, required this.body, required this.icon});

  final String title, body;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
      padding: EdgeInsets.symmetric(
          horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
      decoration: BoxDecoration(
          color: AppColor.rose,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: AppColor.grey, blurRadius: 25, offset: Offset(1, 9))
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
              icon,
              width: 32.px,
              height: 32.px,
              colorFilter:
                  const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
            ),
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          AppText(
            text: title,
            fontColor: AppColor.purple,
            fontWeight: FontWeight.w600,
            fontSize: AppFontSize.sp16,
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          AppText(
            text: body,
            fontColor: AppColor.grey,
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.sp15,
          ),
        ],
      ),
    );
  }
}
