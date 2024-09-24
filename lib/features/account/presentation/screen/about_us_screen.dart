import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_base_model.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_image.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/footer/main_app_footer.dart';
import 'package:mo_wahaj_top/core/widget/header/gradient_header.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/features/account/cubit/about_us_cubit/about_us_cubit.dart';
import 'package:mo_wahaj_top/features/account/presentation/widget/gradient_info.dart';
import 'package:mo_wahaj_top/features/account/presentation/widget/primary_info.dart';
import 'package:mo_wahaj_top/features/account/presentation/widget/secondary_info.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/widget/snack_bar/note_message.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/11/2024.
 */

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
      ),
      body: BlocConsumer<AboutUsCubit, AboutUsState>(
        listener: (context, state) {
          if (state.status == CubitStatus.error) {
            NoteMessage.showErrorSnackBar(
                context: context, text: state.model.error ?? "");
          }
        },
        builder: (context, state) {
          if (state.status == CubitStatus.loading) {
            return Center(
              child: AppCircularProgressIndicator(),
            );
          }

          FireStoreBaseModel model = state.model;

          return SingleChildScrollView(
            child: Column(
              children: [
                GradientHeader(
                    title: model.data?['header_title'] ?? "",
                    subTitle: model.data?['header_subtitle'] ?? ""),
                SizedBox(
                  height: AppHeightSize.h7,
                ),
                PrimaryInfo(
                  info: model.data?['who_we_are'] ?? "",
                ),
                SizedBox(
                  height: AppHeightSize.h2,
                ),
                SecondaryInfo(
                  title: "whyWahaj".tr(),
                  body: model.data?['why_wahaj'] ?? "",
                  icon: AppIcon.questionMark,
                ),
                SizedBox(
                  height: AppHeightSize.h2,
                ),

                Container(
                  width: AppWidthSize.w90,
                  height: AppHeightSize.h30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.white),
                  child: Image.asset(
                    AppImage.newAppIcon2,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: AppHeightSize.h2,
                ),
                // Container(
                //   margin:
                //       EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
                //   padding: const EdgeInsets.all(15),
                //   decoration: BoxDecoration(
                //       color: AppColor.white,
                //       borderRadius: BorderRadius.circular(10),
                //       boxShadow: [
                //         BoxShadow(
                //             color: AppColor.lightGrey,
                //             blurRadius: 25,
                //             offset: Offset(1, 9))
                //       ]),
                //   child: Image.asset(
                //     AppImage.newAppIcon2,
                //
                //   ),
                // ),
                SizedBox(
                  height: AppHeightSize.h2,
                ),
                SecondaryInfo(
                  title: "wahajIdea".tr(),
                  body: model.data?['wahaj_idea'] ?? "",
                  icon: AppIcon.idea,
                ),
                SizedBox(
                  height: AppHeightSize.h2,
                ),
                SecondaryInfo(
                  title: "goals".tr(),
                  body: model.data?['goals'] ?? "",
                  icon: AppIcon.star,
                ),
                SizedBox(
                  height: AppHeightSize.h5,
                ),
                const GradientInfo(),
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
