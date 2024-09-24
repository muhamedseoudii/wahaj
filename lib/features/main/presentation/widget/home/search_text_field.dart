import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.onSubmitted,
    required this.onSearch,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final Function(String) onSubmitted;
  final Function() onSearch;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeightSize.h6,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
            suffixIcon: Padding(
              padding: EdgeInsets.all(AppWidthSize.w3),
              child: InkWell(
                onTap: onSearch,
                child: SvgPicture.asset(
                  AppIcon.search,
                  colorFilter:
                      const ColorFilter.mode(AppColor.grey, BlendMode.srcIn),
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColor.grey, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColor.grey1, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColor.purple, width: 2),
            ),
            hintText: "searchForActivityOrPlace".tr(),
            hintStyle: GoogleFonts.ibmPlexSansArabic(
                color: AppColor.grey, fontSize: AppFontSize.sp15),
            labelStyle: GoogleFonts.ibmPlexSansArabic(
                color: AppColor.black, fontSize: AppFontSize.sp15)),
      ),
    );
  }
}
