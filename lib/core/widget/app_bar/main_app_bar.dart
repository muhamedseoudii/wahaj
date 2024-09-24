import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_image.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';
import 'package:mo_wahaj_top/router/app_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: AppWidthSize.w2, right: AppWidthSize.w2),
      height: AppHeightSize.h7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppImage.newAppIcon,
            height: AppWidthSize.w32,
            width: AppWidthSize.w32,
            fit: BoxFit.contain,
          ),
          Visibility(
            visible: AppSharedPreferences.isLogin() == true,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteName.search);
                  },
                  child: SvgPicture.asset(
                    AppIcon.search,
                    colorFilter:
                        const ColorFilter.mode(AppColor.black, BlendMode.srcIn),
                  ),
                ),
                SizedBox(width: AppWidthSize.w6),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteName.notification);
                  },
                  child: SvgPicture.asset(
                    AppIcon.notification,
                    colorFilter:
                        const ColorFilter.mode(AppColor.black, BlendMode.srcIn),
                  ),
                ),
                // IconButton(
                //     onPressed: () {
                //       Navigator.of(context).pushNamed(RouteName.favorite);
                //     },
                //     icon: Icon(
                //       size: 24.px,
                //       Icons.favorite_rounded,
                //       color: AppColor.purple,
                //     )),
                // IconButton(
                //     onPressed: () {
                //       Navigator.of(context).pushNamed(RouteName.notification);
                //     },
                //     icon: Icon(
                //       size: 24.px,
                //       Icons.notifications,
                //       color: AppColor.purple,
                //     )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
