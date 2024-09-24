import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.error});

  final String error;
  @override
  Widget build(BuildContext context) {
    return AppText(
      text: error,
      fontSize: AppFontSize.sp16,
      fontColor: AppColor.red,
      fontWeight: FontWeight.w600,
    );
  }
}
