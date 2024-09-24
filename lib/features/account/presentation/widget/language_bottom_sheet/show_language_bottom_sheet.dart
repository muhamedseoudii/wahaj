import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';

import '../../../../../core/resource/app_const.dart';

/**
 * Created by Eng.Eyad AlSayed on 6/9/2024.
 */

void showLanguageBottomSheet(
    {required BuildContext context, required Function() onChangeLanguage}) {
  String selectedLanguageCode = AppSharedPreferences.getAppLanguageCode();

  showModalBottomSheet(
    backgroundColor: AppColor.white,
    context: context,
    enableDrag: true,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
        decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppHeightSize.h2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
              child: AppText(
                text: "appLanguage".tr(),
                fontSize: AppFontSize.sp15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            Divider(
              indent: AppWidthSize.w5,
              endIndent: AppWidthSize.w5,
              color: AppColor.purple.withOpacity(0.5),
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            RadioListTile(
              activeColor: AppColor.purple,
              fillColor:
                  MaterialStateColor.resolveWith((states) => AppColor.purple),
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              contentPadding: EdgeInsets.zero,
              title: AppText(
                text: "english".tr(),
                fontSize: AppFontSize.sp16,
                fontWeight: FontWeight.w600,
              ),
              value: AppConst.englishLanguageCode,
              groupValue: selectedLanguageCode,
              onChanged: (value) {
                selectedLanguageCode = value ?? "";
                String languageCode =
                    EasyLocalization.of(context)?.currentLocale?.languageCode ??
                        "";

                if (languageCode == selectedLanguageCode) {
                  Navigator.pop(context);
                  return;
                }
                EasyLocalization.of(context)
                    ?.setLocale(Locale(selectedLanguageCode))
                    .then((value) {
                  AppSharedPreferences.setAppLanguage(
                      languageCode: selectedLanguageCode);
                  Navigator.pop(context);
                  onChangeLanguage();
                });
              },
            ),
            SizedBox(
              height: AppHeightSize.h1,
            ),
            RadioListTile(
              activeColor: AppColor.purple,
              fillColor:
                  MaterialStateColor.resolveWith((states) => AppColor.purple),
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              contentPadding: EdgeInsets.zero,
              title: AppText(
                text: "arabic".tr(),
                fontSize: AppFontSize.sp16,
                fontWeight: FontWeight.w600,
              ),
              value: AppConst.arabicLanguageCode,
              groupValue: selectedLanguageCode,
              onChanged: (value) {
                selectedLanguageCode = value ?? "";
                String languageCode =
                    EasyLocalization.of(context)?.currentLocale?.languageCode ??
                        "";

                if (languageCode == selectedLanguageCode) {
                  Navigator.pop(context);
                  return;
                }
                EasyLocalization.of(context)
                    ?.setLocale(Locale(selectedLanguageCode))
                    .then((value) {
                  AppSharedPreferences.setAppLanguage(
                      languageCode: selectedLanguageCode);
                  Navigator.pop(context);
                  onChangeLanguage();
                });
              },
            ),
            SizedBox(
              height: AppHeightSize.h4,
            ),
          ],
        ),
      );
    },
  );
}
