import 'package:flutter/material.dart';
import '../../resource/app_color.dart';
import '../../resource/app_size.dart';
import '../text/app_text.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.onTap, required this.title});

  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.purple,
            padding: EdgeInsets.symmetric(
                horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
            textStyle: const TextStyle(color: Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: AppHeightSize.h2,
            ),
            AppText(
              text: title,
              fontSize: AppFontSize.sp15,
              fontColor: AppColor.white,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
          ],
        ));
  }
}
