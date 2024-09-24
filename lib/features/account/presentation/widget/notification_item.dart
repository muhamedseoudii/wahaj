import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';

import '../../../../core/resource/app_icon.dart';

/**
 * Created by Eng.Eyad AlSayed on 6/15/2024.
 */

class NotificationItem extends StatelessWidget {
  const NotificationItem(
      {super.key, required this.body, required this.title, required this.date});

  final String title, body, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppWidthSize.w4, vertical: AppHeightSize.h1),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Color.fromARGB(28, 130, 130, 130),
        //     blurRadius: 2,
        //     spreadRadius: 0,
        //     offset:
        //         // changes position of shadow
        //         Offset(3, 5),
        //   ),
        // ],
      ),
      // child: ListTile(
      //   leading: Column(
      //     children: [
      //       SvgPicture.asset(
      //         AppIcon.notIcon,
      //         width: AppWidthSize.w12,
      //         height: AppWidthSize.w12,
      //         // colorFilter:
      //         //     const ColorFilter.mode(AppColor.purple, BlendMode.plus),
      //       ),
      //       SizedBox(
      //         height: AppHeightSize.h3,
      //       ),
      //     ],
      //   ),
      //   title: AppText(
      //     text: title,
      //     fontWeight: FontWeight.w600,
      //     fontSize: AppFontSize.sp16,
      //     fontColor: AppColor.purple,
      //   ),
      //   subtitle: AppText(
      //     textOverflow: TextOverflow.ellipsis,
      //     maxLines: 2,
      //     text: body,
      //     fontWeight: FontWeight.w600,
      //     fontSize: AppFontSize.sp16,
      //   ),
      //   trailing: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       SizedBox(
      //         height: AppHeightSize.h10,
      //       ),
      //       AppText(
      //         text: date,
      //         fontWeight: FontWeight.w600,
      //         fontSize: AppFontSize.sp14,
      //         fontColor: AppColor.grey,
      //       ),
      //     ],
      //   ),
      // ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AppIcon.notIcon,
                width: AppWidthSize.w12,
                height: AppWidthSize.w12,
                // colorFilter:
                //     const ColorFilter.mode(AppColor.purple, BlendMode.plus),
              ),
              SizedBox(
                height: AppHeightSize.h1,
              ),
              SizedBox(
                width: AppWidthSize.w3point8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: title,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontColor: AppColor.purple,
                    ),
                    SizedBox(
                      height: AppHeightSize.h05,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AppText(
                        textOverflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        text: body,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppText(
                text: date,
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.sp14,
                fontColor: AppColor.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
