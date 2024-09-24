import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/router/app_router.dart';
import '../../../../../core/resource/app_color.dart';
import '../../../../../core/resource/app_size.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: "loginForBetterServices".tr(),
          fontSize: AppFontSize.sp16,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: AppHeightSize.h2,
        ),
        SizedBox(
          width: AppWidthSize.w50,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.auth);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.purple,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppWidthSize.w3point8,
                      vertical: AppHeightSize.h1),
                  textStyle: const TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: "login".tr(),
                    fontSize: AppFontSize.sp15,
                    fontColor: AppColor.white,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              )),
        )
      ],
    );
  }
}
