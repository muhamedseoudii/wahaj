import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/image/app_cached_image.dart';
import '../../../../core/widget/text/app_text.dart';

class FavoriteListItem extends StatelessWidget {
  const FavoriteListItem(
      {super.key,
      required this.name,
      required this.image,
      required this.address});

  final String image, name, address;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: AppCachedImage(imageUrl: image),
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
                color:
                    Colors.black.withOpacity(0.1), // Shadow color with opacity
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
                  text: name,
                  fontColor: AppColor.navy,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
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
                    SizedBox(width: AppWidthSize.w1),
                    AppText(
                      text: address,
                      fontColor: AppColor.navy,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
    // return Container(
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
    //   width: double.infinity,
    //   height: AppHeightSize.h25,
    //   child: Stack(
    //     children: [
    //       AppCachedImage(imageUrl: image),
    //       Positioned(
    //           child: Container(
    //         color: AppColor.black.withOpacity(0.2),
    //       )),
    //       Padding(
    //         padding: EdgeInsets.only(
    //             right: AppWidthSize.w3, bottom: AppHeightSize.h2),
    //         child: Align(
    //           alignment: Alignment.bottomRight,
    //           child: AppText(
    //             text: name,
    //             fontColor: Colors.white,
    //             fontSize: AppFontSize.sp18,
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
