import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/auth/presentation/view/phone_number_view.dart';
import 'package:mo_wahaj_top/features/auth/presentation/widget/dialog/signup_dialog.dart';
import 'package:mo_wahaj_top/router/app_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_icon.dart';
import '../../../../core/resource/app_image.dart';
import '../view/login_view.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/12/2024.
 */

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
        initialIndex: 0,
        animationDuration: const Duration(milliseconds: 300),
        length: 1,
        vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppHeightSize.h7,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteName.main, (route) => false);
              },
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
                child: SvgPicture.asset(AppIcon.arrowRight),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.newAppIcon2,
                  width: AppWidthSize.w80,
                  height: AppHeightSize.h30,
                ),
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
            //   child: AppText(
            //     text: "loginByTheFollowingMethod".tr(),
            //     fontWeight: FontWeight.w600,
            //     fontSize: AppFontSize.sp16,
            //   ),
            // ),
            // SizedBox(
            //   height: AppHeightSize.h2,
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       boxShadow: [
            //         BoxShadow(
            //             color: AppColor.lightGrey,
            //             blurRadius: 25,
            //             offset: const Offset(1, 9))
            //       ],
            //       borderRadius: BorderRadius.circular(15)),
            //   clipBehavior: Clip.hardEdge,
            //   child: TabBar(
            //       indicatorSize: TabBarIndicatorSize.tab,
            //       indicatorColor: AppColor.black,
            //       splashBorderRadius: BorderRadius.circular(15),
            //       indicator: BoxDecoration(
            //         color: AppColor.darkPurple,
            //         shape: BoxShape.rectangle,
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       unselectedLabelColor: AppColor.black,
            //       unselectedLabelStyle: LanguageHelper.isEnglishAppLanguage()
            //           ? GoogleFonts.ibmPlexSans(
            //               color: AppColor.white,
            //               fontSize: AppFontSize.sp15,
            //               fontWeight: FontWeight.w600)
            //           : GoogleFonts.ibmPlexSansArabic(
            //               color: AppColor.white,
            //               fontSize: AppFontSize.sp15,
            //               fontWeight: FontWeight.w600),
            //       labelStyle: LanguageHelper.isEnglishAppLanguage()
            //           ? GoogleFonts.ibmPlexSans(
            //               color: AppColor.white,
            //               fontSize: AppFontSize.sp15,
            //               fontWeight: FontWeight.w600)
            //           : GoogleFonts.ibmPlexSansArabic(
            //               color: AppColor.white,
            //               fontSize: AppFontSize.sp15,
            //               fontWeight: FontWeight.w600),
            //       controller: tabController,
            //       tabs: [
            //         Tab(
            //           child: Text("account".tr()),
            //         ),
            //         // Tab(
            //         //   child: Text("phoneNumber".tr()),
            //         // ),
            //       ]),
            // ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            SizedBox(
              height: AppHeightSize.h50,
              child: TabBarView(controller: tabController, children: const [
                LoginView(),
                // PhoneNumberView()
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
