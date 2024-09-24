import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/header/gradient_header.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/account/cubit/contact_us_cubit/contact_us_cubit.dart';
import 'package:mo_wahaj_top/features/account/presentation/widget/contact_us_card.dart';
import 'package:mo_wahaj_top/features/account/presentation/widget/contact_us_form.dart';
import 'package:mo_wahaj_top/features/account/presentation/widget/social_media_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_icon.dart';
import '../../../../core/resource/app_image.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/footer/main_app_footer.dart';
import '../../../../core/widget/snack_bar/note_message.dart';
import '../widget/gradient_info.dart';
import '../widget/primary_info.dart';
import '../widget/secondary_info.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/13/2024.
 */

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset(AppIcon.wahajLogo),
          ),
        ],
      ),
      backgroundColor: AppColor.background,
      body: BlocConsumer<ContactUsCubit, ContactUsState>(
        listener: (context, state) {
          if (state.status == CubitStatus.error) {
            NoteMessage.showErrorSnackBar(
                context: context, text: state.model.error ?? "");
          }
        },
        builder: (context, state) {
          if (state.status == CubitStatus.loading) {
            return Center(child: AppCircularProgressIndicator());
          }
          FireStoreBaseModel model = state.model;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: AppHeightSize.h1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: "toContactUs".tr(),
                          fontColor: AppColor.navy,
                          fontWeight: FontWeight.w600,
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
                          text: "weAreHappyToContactUsAtAnyTime".tr(),
                          fontColor: AppColor.grey2,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFontSize.sp16,
                        ),
                      ],
                    ),
                  ],
                ),
                // GradientHeader(
                //     title: "toContactUs".tr(),
                //     subTitle: "weAreHappyToContactUsAtAnyTime".tr()),
                // SizedBox(
                //   height: AppHeightSize.h7,
                // ),
                // AppText(
                //   text: "stayCloseToUs".tr(),
                //   fontColor: AppColor.purple,
                //   fontSize: AppFontSize.sp18,
                //   fontWeight: FontWeight.bold,
                // ),
                // SizedBox(
                //   height: AppHeightSize.h2,
                // ),
                // AppText(
                //   text: "don'tGoFar,FollowOurSocialMediaAccounts".tr(),
                //   fontColor: AppColor.black,
                //   fontSize: AppFontSize.sp15,
                // ),
                SizedBox(
                  height: AppHeightSize.h4,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.w, left: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialMediaCard(
                        icon: AppIcon.instagramLogo,
                        url: model.data?['instagram_url'] ?? "",
                      ),
                      SocialMediaCard(
                        icon: AppIcon.telegramLogo,
                        url: model.data?['tiktok_url'] ?? "",
                      ),
                      SocialMediaCard(
                        icon: AppIcon.xLogo,
                        url: model.data?['x_url'] ?? "",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppHeightSize.h5,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.w, left: 5.w),
                  child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: AppColor.lightGrey,
                              blurRadius: 15,
                              offset: const Offset(1, 9))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContactUsCard(
                            title: model.data?['location'] ?? "",
                            icon: AppIcon.mapMarker,
                          ),
                          ContactUsCard(
                            title: model.data?['whatsapp_number'] ?? "",
                            icon: AppIcon.whatsLogo,
                          ),
                          ContactUsCard(
                            title: model.data?['email'] ?? "",
                            icon: AppIcon.smsLogo,
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: AppHeightSize.h5,
                ),
                const ContactUsForm(),
                SizedBox(
                  height: AppHeightSize.h5,
                ),
                const MainAppFooter(),
              ],
            ),
          );
        },
      ),
    );
  }
}
