import 'package:flutter/material.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';

class PlaceBannerItem extends StatelessWidget {
  const PlaceBannerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppHeightSize.h7,
      margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w1point5),
      decoration: BoxDecoration(
          color: AppColor.purple, borderRadius: BorderRadius.circular(15)),
    );
  }
}
