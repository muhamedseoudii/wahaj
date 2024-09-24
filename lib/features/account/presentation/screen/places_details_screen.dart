import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/image/app_cached_image.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PlaceDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;

  const PlaceDetailScreen({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        title: AppText(
          text: name,
          fontSize: AppFontSize.sp20,
          fontWeight: FontWeight.w500,
          fontColor: AppColor.navy,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250.px,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: AppCachedImage(imageUrl: imageUrl),
              ),
              SizedBox(height: 16.px),
              AppText(
                text: "desc".tr(),
                fontColor: AppColor.navy,
                fontSize: AppFontSize.sp18,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 8.px),
              AppText(
                text: description,
                fontColor: AppColor.navy,
                fontSize: AppFontSize.sp15,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
