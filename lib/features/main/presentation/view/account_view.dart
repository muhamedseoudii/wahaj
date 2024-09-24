import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/account/login_widget.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/account/profile_widget.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/account/secondary_account_list.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../widget/account/account_item.dart';
import '../widget/account/basic_account_list.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/26/2024.
 */

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
        child: Column(
          children: [
            SizedBox(
              height: AppHeightSize.h7,
            ),
            Visibility(
                visible: AppSharedPreferences.isLogin() == true,
                replacement: const LoginWidget(),
                child: const ProfileWidget()),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: AppSharedPreferences.isLogin() == true,
                      child: AppText(
                        text: "basics".tr(),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                // Visibility(
                //   visible: AppSharedPreferences.isLogin() == true,
                //   child: SizedBox(
                //     height: AppHeightSize.h2,
                //   ),
                // ),
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
                    height: AppHeightSize.h1point2,
                  ),
                ),
                Visibility(
                  visible: AppSharedPreferences.isLogin() == true,
                  child: AccountItem(
                      onTap: () {
                        Navigator.of(context).pushNamed(RouteName.favorite);
                      },
                      icon: AppIcon.favorite,
                      text: "favorite_list".tr()),
                ),
                // Visibility(
                //   visible: AppSharedPreferences.isLogin() == true,
                //   child: SizedBox(
                //     height: AppHeightSize.h4,
                //   ),
                // ),
                // Visibility(
                //   visible: AppSharedPreferences.isLogin() == true,
                //   child: AccountItem(
                //       onTap: () {
                //         Navigator.of(context)
                //             .pushNamed(RouteName.bookingHistory);
                //       },
                //       text: "bookings".tr()),
                // ),
                Visibility(
                  visible: AppSharedPreferences.isLogin() == true,
                  child: SizedBox(
                    height: AppHeightSize.h1point2,
                  ),
                ),
                AccountItem(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.places);
                    },
                    icon: AppIcon.map,
                    text: "places".tr()),
                SizedBox(
                  height: AppHeightSize.h1point2,
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
                    height: AppHeightSize.h1point2,
                  ),
                ),
                AccountItem(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.contactUs);
                    },
                    icon: AppIcon.call,
                    text: "contactUs".tr()),
                SizedBox(
                  height: AppHeightSize.h1point2,
                ),
              ],
            ),
            SizedBox(
              height: AppHeightSize.h1point2,
            ),
            Row(
              children: [
                AppText(
                  text: "settings".tr(),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ],
            ),
            SizedBox(
              height: AppHeightSize.h1point2,
            ),
            SecondaryAccountList(
              onChangeLanguage: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
