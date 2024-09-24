import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import '../../../features/account/presentation/screen/about_us_screen.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/11/2024.
 */

class GradientHeader extends StatelessWidget {
  const GradientHeader(
      {super.key, required this.title, required this.subTitle});

  final String title, subTitle;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RoundedArcClipper(),
      child: Container(
        height: AppHeightSize.h50,
        decoration: const BoxDecoration(
            gradient: AppGradient.darkOrangePurpleTopBottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: title,
                  fontColor: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.sp18,
                ),
              ],
            ),
            SizedBox(
              height: AppHeightSize.h1point8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: subTitle,
                  fontColor: AppColor.white,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSize.sp16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height); // Move to the bottom left corner
    path.lineTo(
        0,
        size.height -
            40); // Draw a vertical line up to create space for the arc
    path.quadraticBezierTo(size.width / 2, size.height + 40, size.width,
        size.height - 40); // Draw a quadratic bezier curve for the arc
    path.lineTo(size.width, 0); // Draw a line to the top right corner
    path.lineTo(0, 0); // Draw a line to the top left corner to close the path
    path.close(); // Close the path to form a closed shape
    return path; // Return the completed path
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
