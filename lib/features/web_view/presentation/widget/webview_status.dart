import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/resource/app_color.dart';

/**
 * Created by Eng.Eyad AlSayed on 4/23/2024.
 */

class WebViewStatus extends StatelessWidget {
  WebViewStatus({super.key, required this.pageStatus});

  final int pageStatus;
  @override
  Widget build(BuildContext context) {
    return pageStatus == 0
        ? const Center(
            child: CircularProgressIndicator(
            color: AppColor.purple,
          ))
        : pageStatus == 2
            ? Center(
                child: AppText(
                text: "تعذر تحميل الصفحة",
                fontWeight: FontWeight.bold,
                fontColor: AppColor.darkRed,
                fontSize: AppFontSize.sp20,
              ))
            : const SizedBox();
  }
}
