import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';
import 'package:mo_wahaj_top/core/widget/button/main_button.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../../resource/app_color.dart';
import '../../resource/app_size.dart';
import '../text/app_text.dart';

/**
 * Created by Eng.Eyad AlSayed on 7/7/2024.
 */

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onTap, required this.child});

  final Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (AppSharedPreferences.isLogin() == true) {
          onTap();
          return;
        }
        showLoginBottomSheet(context: context);
      },
      child: child,
    );
  }
}

void showLoginBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
              left: AppWidthSize.w5,
              right: AppWidthSize.w5,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: const BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: AppHeightSize.h2,
              ),
              AppText(
                text: "loginFirst".tr(),
                fontSize: AppFontSize.sp16,
              ),
              SizedBox(
                height: AppHeightSize.h2,
              ),
              AppText(
                text: "loginForBetterServices".tr(),
                fontSize: AppFontSize.sp16,
              ),
              SizedBox(
                height: AppHeightSize.h4,
              ),
              MainButton(onTap: () {
                Navigator.pushNamed(context, RouteName.auth);
              }, title: 'login'.tr()),
              SizedBox(
                height: AppHeightSize.h2,
              ),
            ],
          ),
        );
      });
}
