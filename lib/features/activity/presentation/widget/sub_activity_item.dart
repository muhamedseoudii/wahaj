import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/widget/button/login_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/firebase/firebase_core/firestore_method.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/image/app_cached_image.dart';
import '../../../../core/widget/text/app_text.dart';

class SubActivityItem extends StatefulWidget {
  const SubActivityItem(
      {super.key,
      required this.onTap,
      required this.imageUrl,
      required this.arName,
      required this.enName,
      required this.enAddress,
      required this.arAddress});

  final Function() onTap;
  final String imageUrl, arName, enName, enAddress, arAddress;

  @override
  State<SubActivityItem> createState() => _SubActivityItemState();
}

class _SubActivityItemState extends State<SubActivityItem> {
  @override
  void initState() {
    FireStoreAddMethod.addActivityView(body: {
      'activity_name': widget.enName,
      'image': widget.imageUrl,
      'out_view': true,
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginButton(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            width: double.infinity,
            height: AppHeightSize.h25,
            child: AppCachedImage(imageUrl: widget.imageUrl),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.1), // Shadow color with opacity
                  spreadRadius: 2, // The spread of the shadow
                  blurRadius: 8, // How blurry the shadow is
                  offset: const Offset(0, 4), // Offset of the shadow (x, y)
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LanguageHelper.isEnglishAppLanguage()
                        ? widget.enName
                        : widget.arName,
                    fontColor: AppColor.navy,
                    fontSize: AppFontSize.sp18,
                  ),
                  SizedBox(height: AppHeightSize.h05),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppIcon.mapMarker,
                        width: 20.px,
                        height: 20.px,
                        colorFilter: const ColorFilter.mode(
                            AppColor.purple, BlendMode.srcIn),
                      ),
                      SizedBox(width: AppWidthSize.w2),
                      AppText(
                        text: LanguageHelper.isEnglishAppLanguage()
                            ? widget.enAddress
                            : widget.arAddress,
                        fontColor: AppColor.navy,
                        fontSize: AppFontSize.sp16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Container(
// clipBehavior: Clip.antiAliasWithSaveLayer,
// decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
// width: double.infinity,
// height: AppHeightSize.h25,
// child: Stack(
// children: [
// AppCachedImage(imageUrl: widget.imageUrl),
// Positioned(
// child: Container(
// color: AppColor.black.withOpacity(0.2),
// )),
// Padding(
// padding: EdgeInsets.only(
// right: AppWidthSize.w3,
// left: AppWidthSize.w3,
// bottom: AppHeightSize.h2),
// child: Align(
// alignment: LanguageHelper.isEnglishAppLanguage()
// ? Alignment.bottomLeft
//     : Alignment.bottomRight,
// child: AppText(
// text: LanguageHelper.isEnglishAppLanguage()
// ? widget.enName
//     : widget.arName,
// fontColor: Colors.white,
// fontSize: AppFontSize.sp18,
// ),
// ),
// )
// ],
// ),
// ),
