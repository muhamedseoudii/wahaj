import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/widget/image/app_cached_image.dart';
import '../../../../core/widget/text/app_text.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/28/2024.
 */

class PlacesTabView extends StatelessWidget {
  const PlacesTabView({super.key, required this.places});

  final List<Map<String, dynamic>> places;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: places.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.places);
            },
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              width: double.infinity,
              height: AppHeightSize.h25,
              child: Stack(
                children: [
                  AppCachedImage(imageUrl: places[index]['image'] ?? ""),
                  Positioned(
                      child: Container(
                    color: AppColor.black.withOpacity(0.2),
                  )),
                  Padding(
                    padding: EdgeInsets.only(
                        right: AppWidthSize.w3, bottom: AppHeightSize.h2),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: AppText(
                        text: LanguageHelper.isEnglishAppLanguage()
                            ? places[index]['en_name'] ?? ""
                            : places[index]['ar_name'] ?? "",
                        fontColor: Colors.white,
                        fontSize: AppFontSize.sp18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: AppHeightSize.h2,
          ),
        ));
  }
}
