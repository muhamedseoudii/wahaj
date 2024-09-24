import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/router/app_router.dart';
import '../../../../core/resource/app_color.dart';

class GradientInfo extends StatelessWidget {
  const GradientInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
      padding: EdgeInsets.symmetric(
          horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColor.lightGrey, blurRadius: 25, offset: Offset(1, 9))
          ],
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColor.darkOrange, AppColor.purple])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: "doYouWantToKnowAboutYourCountry".tr(),
            fontSize: AppFontSize.sp16,
            fontColor: AppColor.white,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          AppText(
            text: "doYouWantToKnowAboutYourCountryData".tr(),
            fontSize: AppFontSize.sp15,
            fontColor: AppColor.white,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: AppHeightSize.h2,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.places);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.white,
                  surfaceTintColor: AppColor.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppWidthSize.w3point8,
                      vertical: AppHeightSize.h2),
                  textStyle: const TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: AppText(
                text: "explorePlaces".tr(),
                fontSize: AppFontSize.sp15,
                fontColor: AppColor.black,
                fontWeight: FontWeight.w500,
              ))
        ],
      ),
    );
  }
}
