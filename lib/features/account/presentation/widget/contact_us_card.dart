import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/widget/text/app_text.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/14/2024.
 */

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({super.key, required this.title, required this.icon});

  final String title, icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        colorFilter: const ColorFilter.mode(AppColor.purple, BlendMode.srcIn),
      ),
      title: AppText(
        text: title,
        fontColor: AppColor.black,
        fontSize: AppFontSize.sp15,
      ),
    );

    // return Container(
    //   width: AppWidthSize.w80,
    //   padding: EdgeInsets.symmetric(
    //       horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
    //   decoration: BoxDecoration(
    //       color: AppColor.white,
    //       borderRadius: BorderRadius.circular(10),
    //       boxShadow: [
    //         BoxShadow(
    //             color: AppColor.lightGrey, blurRadius: 25, offset: Offset(1, 9))
    //       ]),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         decoration: BoxDecoration(
    //             color: AppColor.darkOrange,
    //             borderRadius: BorderRadius.circular(10)),
    //         padding: EdgeInsets.symmetric(
    //             horizontal: AppWidthSize.w2point5,
    //             vertical: AppHeightSize.h1point2),
    //         child: SvgPicture.asset(
    //           icon,
    //           width: 24.px,
    //           height: 24.px,
    //           colorFilter:
    //               const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
    //         ),
    //       ),
    //       SizedBox(
    //         height: AppHeightSize.h2,
    //       ),
    //       AppText(
    //         text: title,
    //         fontColor: AppColor.black,
    //         fontWeight: FontWeight.w600,
    //         fontSize: AppFontSize.sp16,
    //       ),
    //       SizedBox(
    //         height: AppHeightSize.h2,
    //       ),
    //       AppText(
    //         text: subTitle,
    //         fontColor: AppColor.black,
    //         fontSize: AppFontSize.sp15,
    //       ),
    //     ],
    //   ),
    // );
  }
}
