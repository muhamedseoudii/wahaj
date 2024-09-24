import 'package:flutter/material.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/11/2024.
 */

class PlaceBannerItem extends StatelessWidget {
  const PlaceBannerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppHeightSize.h7,
      margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w1point5),
      decoration: BoxDecoration(
          color: AppColor.purple,
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
