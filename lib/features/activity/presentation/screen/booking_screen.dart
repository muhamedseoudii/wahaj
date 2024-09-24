import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/footer/main_app_footer.dart';
import '../../../../core/widget/header/gradient_header.dart';
import '../widget/booking_form.dart';

class BookingArgs {
  String subActivityArName;
  String subActivityEnName;
  String collectionName;
  BookingArgs(
      {required this.subActivityEnName,
      required this.subActivityArName,
      required this.collectionName});
}

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key, required this.args});

  final BookingArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientHeader(
                title: "bookingNow".tr(),
                subTitle:
                    "${"bookingNowIn".tr()} ${LanguageHelper.isEnglishAppLanguage() ? args.subActivityEnName : args.subActivityArName}"),
            SizedBox(
              height: AppHeightSize.h7,
            ),
            BookingForm(
              collectionName: args.collectionName,
              subActivityArName: args.subActivityArName,
              subActivityEnName: args.subActivityEnName,
            ),
            SizedBox(
              height: AppHeightSize.h5,
            ),
            const MainAppFooter(),
          ],
        ),
      ),
    );
  }
}
