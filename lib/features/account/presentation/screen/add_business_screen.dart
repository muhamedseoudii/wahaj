import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_image.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../widget/add_business_form.dart';

class AddBusinessScreen extends StatelessWidget {
  const AddBusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(children: [
        Image.asset(AppImage.advertiseLogo),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      radius: 15,
                      child: SvgPicture.asset(AppIcon.iosArrowLeft),
                    ),
                  ),
                  SizedBox(height: AppHeightSize.h4),
                  AppText(
                    text: "addYourBusinessNow".tr(),
                    fontColor: Colors.white,
                    fontSize: 24.px,
                    fontWeight: FontWeight.w500,
                  ),
                  AppText(
                    text: "joinUsAndAddYourWorkNow".tr(),
                    fontColor: Colors.white,
                    fontSize: 14.px,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
      bottomSheet: SizedBox(
        height: AppHeightSize.h80,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppHeightSize.h2,
                  ),
                  SvgPicture.asset(AppIcon.wahajLogo),
                  const AddBusinessForm(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// SingleChildScrollView(
// child: Column(
// children: [
// GradientHeader(
// title: "addYourBusinessNow".tr(),
// subTitle: "joinUsAndAddYourWorkNow".tr()),
// SizedBox(
// height: AppHeightSize.h7,
// ),
// const AddBusinessForm(),
// SizedBox(
// height: AppHeightSize.h5,
// ),
// const MainAppFooter(),
// ],
// ),
// ),
