import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/features/account/presentation/widget/language_bottom_sheet/show_language_bottom_sheet.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/account/account_item.dart';
import '../../../../../core/resource/app_color.dart';
import '../../../../../core/widget/snack_bar/note_message.dart';
import '../../../../../router/app_router.dart';
import '../../../cubit/delete_user_cubit/delete_user_cubit.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/26/2024.
 */

class SecondaryAccountList extends StatelessWidget {
  const SecondaryAccountList({super.key, required this.onChangeLanguage});

  final Function() onChangeLanguage;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      runAlignment: WrapAlignment.spaceEvenly,
      spacing: AppHeightSize.h03,
      runSpacing: AppHeightSize.h2,
      children: [
        SettingsItem(
            onTap: () {
              showLanguageBottomSheet(
                  context: context, onChangeLanguage: onChangeLanguage);
            },
            icon: AppIcon.translate,
            color: AppColor.purple,
            text: "language".tr()),
        SizedBox(
          height: AppHeightSize.h2,
        ),
        SettingsItem(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.aboutUs);
            },
            icon: AppIcon.note,
            color: AppColor.purple,
            text: "aboutUs".tr()),
        SizedBox(
          height: AppHeightSize.h2,
        ),
        SettingsItem(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.webView);
            },
            icon: AppIcon.global,
            color: AppColor.purple,
            text: "visitOurWebsite".tr()),
        SizedBox(
          height: AppHeightSize.h2,
        ),
        SettingsItem(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.privacyPolicy);
            },
            icon: AppIcon.shieldTick,
            color: AppColor.purple,
            text: "privacyPolicy".tr()),
        Visibility(
          visible: AppSharedPreferences.isLogin() == true,
          child: SizedBox(
            height: AppHeightSize.h2,
          ),
        ),
        Visibility(
          visible: AppSharedPreferences.isLogin() == true,
          child: SettingsItem(
              onTap: () {
                AppSharedPreferences.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(RouteName.auth, (route) => false);
              },
              icon: AppIcon.logout,
              color: AppColor.purple,
              text: "signOut".tr()),
        ),
        Visibility(
          visible: AppSharedPreferences.isLogin() == true,
          child: SizedBox(
            height: AppHeightSize.h2,
          ),
        ),
        Visibility(
          visible: AppSharedPreferences.isLogin() == true,
          child: BlocConsumer<DeleteUserCubit, DeleteUserState>(
            listener: (context, state) {
              if (state.status == CubitStatus.error) {
                NoteMessage.showErrorSnackBar(
                    context: context, text: state.model.error ?? "");
              }
              if (state.status == CubitStatus.success) {
                AppSharedPreferences.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(RouteName.auth, (route) => false);
              }
            },
            builder: (context, state) {
              if (state.status == CubitStatus.loading) {
                return Center(
                  child: AppCircularProgressIndicator(
                    loadingColor: AppColor.darkRed,
                  ),
                );
              }

              return SettingsItem(
                  isDeleteItem: true,
                  onTap: () {
                    context.read<DeleteUserCubit>().deleteUser();
                  },
                  icon: AppIcon.trash,
                  color: AppColor.red,
                  text: "deleteAccount".tr());
            },
          ),
        ),
        SizedBox(
          height: AppHeightSize.h2,
        ),
      ],
    );
  }
}
