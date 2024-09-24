import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import '../../../../core/resource/app_color.dart';

class WebViewStatus extends StatelessWidget {
  const WebViewStatus({super.key, required this.pageStatus});

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
