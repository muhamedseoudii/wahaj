import 'package:flutter/material.dart';
import '../../../../../core/helper/language_helper.dart';
import '../../../../../core/resource/app_color.dart';
import '../../../../../core/resource/app_size.dart';
import '../../../../../core/widget/image/app_cached_image.dart';
import '../../../../../core/widget/text/app_text.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem(
      {super.key, required this.activitiesData, required this.onTap});

  final Map<String, dynamic> activitiesData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        width: AppWidthSize.w175,
        height: AppHeightSize.h232,
        child: Stack(
          children: [
            AppCachedImage(imageUrl: activitiesData['image'] ?? ""),
            Positioned(
                child: Container(
              color: AppColor.black.withOpacity(0.4),
            )),
            Padding(
              padding: EdgeInsets.only(
                right: AppWidthSize.w3,
                left: AppWidthSize.w3,
                bottom: AppHeightSize.h1,
              ),
              child: Align(
                alignment: LanguageHelper.isEnglishAppLanguage()
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
                child: AppText(
                  text: LanguageHelper.isEnglishAppLanguage()
                      ? activitiesData['en_name'] ?? ""
                      : activitiesData['ar_name'] ?? "",
                  fontColor: Colors.white,
                  fontSize: AppFontSize.sp18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
