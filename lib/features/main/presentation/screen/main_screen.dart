import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/main/presentation/view/account_view.dart';
import 'package:mo_wahaj_top/features/main/presentation/view/home_view.dart';
import 'package:mo_wahaj_top/features/main/presentation/view/offers_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/widget/app_bar/main_app_bar.dart';
import '../view/activities_view.dart';

class MainArgs {
  int openIndex;

  MainArgs({this.openIndex = 0});
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.args});

  final MainArgs args;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List screens = [
    const HomeView(),
    const ActivitiesView(),
    const OffersView(),
    const AccountView(),
  ];
  int selectedScreenIdx = 0;

  @override
  void initState() {
    selectedScreenIdx = widget.args.openIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectedScreenIdx == 0,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          setState(() {
            selectedScreenIdx = 0;
          });
        } else {
          FlutterExitApp.exitApp(iosForceExit: true);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: Builder(builder: (context) {
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Column(
                children: [
                  Visibility(
                      visible: hideAppBar() == false,
                      child: SizedBox(
                        height: AppHeightSize.h5,
                      )),
                  Visibility(
                      visible: hideAppBar() == false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidthSize.w3point8),
                        child: const MainAppBar(),
                      )),
                  Expanded(child: screens[selectedScreenIdx]),
                ],
              ));
        }),
        bottomNavigationBar: BottomAppBar(
          height: AppHeightSize.h10,
          color: AppColor.white,
          padding: EdgeInsets.zero,
          surfaceTintColor: AppColor.white,
          elevation: Platform.isIOS ? 0 : 5,
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.transparent,
              splashColor: Colors.transparent,
              unselectedWidgetColor: Colors.transparent,
              primaryColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              elevation: Platform.isIOS ? 0 : 5,
              onTap: (index) {
                setState(() {
                  selectedScreenIdx = index;
                });
              },
              currentIndex: selectedScreenIdx,
              backgroundColor: AppColor.white,
              selectedLabelStyle: LanguageHelper.isEnglishAppLanguage()
                  ? GoogleFonts.ibmPlexSans()
                  : GoogleFonts.ibmPlexSansArabic(),
              unselectedLabelStyle: LanguageHelper.isEnglishAppLanguage()
                  ? GoogleFonts.ibmPlexSans()
                  : GoogleFonts.ibmPlexSansArabic(),
              selectedItemColor: AppColor.purple,
              unselectedItemColor: AppColor.grey,
              selectedFontSize: AppFontSize.sp15,
              unselectedFontSize: AppFontSize.sp15,
              items: [
                BottomNavigationBarItem(
                    backgroundColor: AppColor.white,
                    activeIcon: SvgPicture.asset(
                      width: 24.px,
                      height: 24.px,
                      AppIcon.home,
                      colorFilter: const ColorFilter.mode(
                          AppColor.purple, BlendMode.srcIn),
                    ),
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          width: 24.px,
                          height: 24.px,
                          AppIcon.home,
                          colorFilter: const ColorFilter.mode(
                              AppColor.grey, BlendMode.srcIn),
                        ),
                        AppText(
                          text: "explorer".tr(),
                          fontColor: AppColor.grey,
                          fontSize: AppFontSize.sp13,
                        )
                      ],
                    ),
                    label: "explorer".tr()),
                BottomNavigationBarItem(
                    backgroundColor: AppColor.white,
                    activeIcon: SvgPicture.asset(
                      width: 24.px,
                      height: 24.px,
                      AppIcon.mapMarker,
                      colorFilter: const ColorFilter.mode(
                          AppColor.purple, BlendMode.srcIn),
                    ),
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          width: 24.px,
                          height: 24.px,
                          AppIcon.mapMarker,
                          colorFilter: const ColorFilter.mode(
                              AppColor.grey, BlendMode.srcIn),
                        ),
                        AppText(
                          text: "activities".tr(),
                          fontColor: AppColor.grey,
                          fontSize: AppFontSize.sp13,
                        )
                      ],
                    ),
                    label: "activities".tr()),
                BottomNavigationBarItem(
                    backgroundColor: AppColor.white,
                    activeIcon: SvgPicture.asset(
                      width: 24.px,
                      height: 24.px,
                      AppIcon.offer,
                      colorFilter: const ColorFilter.mode(
                          AppColor.purple, BlendMode.srcIn),
                    ),
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          width: 24.px,
                          height: 24.px,
                          AppIcon.offer,
                          colorFilter: const ColorFilter.mode(
                              AppColor.grey, BlendMode.srcIn),
                        ),
                        AppText(
                          text: "offer".tr(),
                          fontColor: AppColor.grey,
                          fontSize: AppFontSize.sp13,
                        )
                      ],
                    ),
                    label: "offer".tr()),
                BottomNavigationBarItem(
                    backgroundColor: AppColor.white,
                    activeIcon: SvgPicture.asset(
                      width: 24.px,
                      height: 24.px,
                      AppIcon.account,
                      colorFilter: const ColorFilter.mode(
                          AppColor.purple, BlendMode.srcIn),
                    ),
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          width: 24.px,
                          height: 24.px,
                          AppIcon.account,
                          colorFilter: const ColorFilter.mode(
                              AppColor.grey, BlendMode.srcIn),
                        ),
                        AppText(
                          text: "more".tr(),
                          fontColor: AppColor.grey,
                          fontSize: AppFontSize.sp13,
                        )
                      ],
                    ),
                    label: "more".tr()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool hideAppBar() {
    return selectedScreenIdx == 3 || selectedScreenIdx == 2;
  }
}
