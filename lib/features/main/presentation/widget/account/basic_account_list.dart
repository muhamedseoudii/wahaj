import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/account/account_item.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../../../../../core/storage/shared_pref/shared_preferences.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/26/2024.
 */

class BasicAccountList extends StatefulWidget {
  const BasicAccountList({super.key});

  @override
  State<BasicAccountList> createState() => _BasicAccountListState();
}

class _BasicAccountListState extends State<BasicAccountList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: AppSharedPreferences.isLogin() == true,
          child: AccountItem(
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.notification);
              },
              icon: AppIcon.notification,
              text: "notifications".tr()),
        ),
        Visibility(
          visible: AppSharedPreferences.isLogin() == true,
          child: SizedBox(
            height: AppHeightSize.h4,
          ),
        ),
        Visibility(
          visible: AppSharedPreferences.isLogin() == true,
          child: AccountItem(
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.bookingHistory);
              },
              icon: AppIcon.notification,
              text: "bookings".tr()),
        ),
        Visibility(
          visible: AppSharedPreferences.isLogin() == true,
          child: SizedBox(
            height: AppHeightSize.h4,
          ),
        ),
        AccountItem(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.places);
            },
            icon: AppIcon.map,
            text: "places".tr()),
        SizedBox(
          height: AppHeightSize.h2,
        ),
        Visibility(
          visible: AppSharedPreferences.isLogin() == true,
          child: AccountItem(
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.addBusiness);
              },
              icon: AppIcon.star,
              text: "addYourBusinessNow".tr()),
        ),
        Visibility(
          visible: AppSharedPreferences.isLogin() == true,
          child: SizedBox(
            height: AppHeightSize.h4,
          ),
        ),
        AccountItem(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.contactUs);
            },
            icon: AppIcon.call,
            text: "contactUs".tr()),
        SizedBox(
          height: AppHeightSize.h2,
        ),
      ],
    );
  }
}
