import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/widget/continer/decorated_container.dart';

class AccountItem extends StatelessWidget {
  const AccountItem(
      {super.key,
      required this.text,
      required this.onTap,
      this.isDeleteItem = false,
      required this.icon});

  final String text, icon;
  final Function() onTap;
  final bool isDeleteItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedContainer(
        borderRadius: BorderRadius.circular(10),
        padding: EdgeInsets.symmetric(
            horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 24.px,
                  height: 24.px,
                  colorFilter:
                      const ColorFilter.mode(AppColor.purple, BlendMode.srcIn),
                ),
                SizedBox(width: AppWidthSize.w2),
                AppText(
                  text: text,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSize.sp16,
                  fontColor: isDeleteItem ? AppColor.darkRed : AppColor.black,
                ),
              ],
            ),
            Icon(
              isDeleteItem
                  ? Icons.remove_circle_outlined
                  : Icons.arrow_forward_ios,
              color: isDeleteItem ? AppColor.darkRed : AppColor.black,
              size: isDeleteItem ? AppWidthSize.w5 : AppWidthSize.w4,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.text,
      required this.onTap,
      this.isDeleteItem = false,
      required this.icon,
      required this.color});

  final String text, icon;
  final Color color;
  final Function() onTap;
  final bool isDeleteItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedContainer(
        height: AppHeightSize.h8,
        width: AppWidthSize.w45,
        borderRadius: BorderRadius.circular(10),
        padding: EdgeInsets.symmetric(
            horizontal: AppWidthSize.w3, vertical: AppHeightSize.h2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 24.px,
                  height: 24.px,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                SizedBox(width: AppWidthSize.w2),
                AppText(
                  text: text,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSize.sp16,
                  fontColor: isDeleteItem ? AppColor.darkRed : AppColor.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
