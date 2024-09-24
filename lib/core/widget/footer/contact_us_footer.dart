import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';

import '../../../features/account/cubit/contact_us_cubit/contact_us_cubit.dart';
import '../../../features/account/presentation/widget/social_media_card.dart';
import '../../firebase/firebase_core/firestore_base_model.dart';
import '../../resource/app_icon.dart';
import '../../resource/app_image.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/11/2024.
 */

class ContactUsFooter extends StatelessWidget {
  const ContactUsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactUsCubit, ContactUsState>(
      listener: (context, state) {},
      builder: (context, state) {
        FireStoreBaseModel model = state.model;
        return Column(
          children: [
            SizedBox(
              height: AppHeightSize.h2,
            ),
            AppText(
              text: "stayCloseToUs".tr(),
              fontColor: AppColor.purple,
              fontSize: AppFontSize.sp18,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            AppText(
              text: "don'tGoFar,FollowOurSocialMediaAccounts".tr(),
              fontColor: AppColor.black,
              fontSize: AppFontSize.sp15,
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialMediaCard(
                  icon: AppIcon.xapp,
                  url: model.data?['x_url'] ?? "",
                ),
                SocialMediaCard(
                  icon: AppIcon.tiktok,
                  url: model.data?['tiktok_url'] ?? "",
                ),
                SocialMediaCard(
                  icon: AppIcon.instagram,
                  url: model.data?['instagram_url'] ?? "",
                ),
              ],
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            Container(
              color: AppColor.purple,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImage.newAppIconWhite,
                        width: AppWidthSize.w50,
                        height: AppHeightSize.h15,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColor.darkOrange,
                    endIndent: AppWidthSize.w3point8,
                    indent: AppWidthSize.w3point8,
                  ),
                  SizedBox(
                    height: AppHeightSize.h1,
                  ),
                  AppText(
                    text: "copyRight".tr(),
                    fontColor: AppColor.white,
                    fontSize: AppFontSize.sp15,
                  ),
                  SizedBox(
                    height: AppHeightSize.h1,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
