import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingHistoryItem extends StatelessWidget {
  const BookingHistoryItem(
      {super.key,
      required this.fullName,
      required this.numberOfPerson,
      required this.phoneNumber,
      required this.email,
      required this.status,
      required this.note,
      required this.place});

  final String fullName,
      numberOfPerson,
      place,
      phoneNumber,
      email,
      status,
      note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: AppColor.lightGrey,
            blurRadius: 3,
            offset: const Offset(1, 3))
      ], borderRadius: BorderRadius.circular(15), color: AppColor.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: fullName,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.sp16,
              ),
              AppText(
                text: place,
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.sp16,
              ),
            ],
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          AppText(
            text: phoneNumber,
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.sp16,
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          AppText(
            text: email,
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.sp16,
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AppIcon.groupPerson,
                width: 24.px,
                height: 24.px,
              ),
              SizedBox(
                width: AppWidthSize.w1,
              ),
              AppText(
                text: numberOfPerson,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.sp16,
              ),
            ],
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: note,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.sp16,
              ),
              AppText(
                text: status,
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.sp16,
                fontColor: AppColor.darkOrange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
