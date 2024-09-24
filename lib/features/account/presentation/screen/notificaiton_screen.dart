import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/account/cubit/notification_cubit/notificaiton_cubit.dart';
import 'package:mo_wahaj_top/features/account/presentation/widget/notification_item.dart';
import 'package:mo_wahaj_top/features/main/presentation/screen/main_screen.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../../../../core/resource/app_icon.dart';
import '../../../../core/widget/snack_bar/note_message.dart';

/**
 * Created by Eng.Eyad AlSayed on 6/9/2024.
 */

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        title: AppText(
          text: "notifications".tr(),
          fontSize: AppFontSize.sp20,
          fontWeight: FontWeight.w400,
          fontColor: AppColor.navy,
        ),
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
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

          List<Map<String, dynamic>> data =
              (state.model.data?['notifications'] ?? [])
                  .cast<Map<String, dynamic>>();

          if (data.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          AppIcon.emptyNotification,
                          width: AppWidthSize.w30,
                          height: AppWidthSize.w30,
                          colorFilter: const ColorFilter.mode(
                              AppColor.purple, BlendMode.srcIn),
                        ),
                        AppText(
                          text: "emptyNotification".tr(),
                          fontSize: AppFontSize.sp17,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColor.purple,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }

          return ListView.separated(
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.main,
                          arguments: MainArgs(openIndex: 1));
                    },
                    child: NotificationItem(
                      title: LanguageHelper.isEnglishAppLanguage()
                          ? data[index]['en_title'] ?? ""
                          : data[index]['ar_title'] ?? "",
                      body: LanguageHelper.isEnglishAppLanguage()
                          ? data[index]['en_body'] ?? ""
                          : data[index]['ar_body'] ?? "",
                      date: data[index]['date'] ?? "",
                    ),
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: AppHeightSize.h2,
                  ),
              itemCount: data.length);
        },
      ),
    );
  }
}
