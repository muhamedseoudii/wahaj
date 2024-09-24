import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/account/cubit/privacy_policy_cubit/privacy_policy_cubit.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/footer/main_app_footer.dart';
import '../../../../core/widget/snack_bar/note_message.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
      ),
      backgroundColor: AppColor.background,
      body: BlocConsumer<PrivacyPolicyCubit, PrivacyPolicyState>(
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

          List<String> titles = [];
          state.model.data?['titles'].forEach((v) {
            titles.add(v.toString());
          });

          List<String> bodies = [];
          state.model.data?['bodies'].forEach((v) {
            bodies.add(v.toString());
          });

          String privacyPolicyDate =
              state.model.data?['privacy_policy_date'] ?? "";

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: AppHeightSize.h15,
                  color: AppColor.purple,
                  alignment: Alignment.center,
                  child: AppText(
                    text: "privacyPolicy".tr(),
                    fontWeight: FontWeight.bold,
                    fontColor: Colors.white,
                    fontSize: AppFontSize.sp18,
                  ),
                ),
                SizedBox(
                  height: AppHeightSize.h1point5,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: titles[index],
                              fontWeight: FontWeight.bold,
                              fontSize: AppFontSize.sp18,
                              fontColor: AppColor.black,
                            ),
                            SizedBox(height: AppHeightSize.h2),
                            AppText(
                              text: bodies[index],
                              fontSize: AppFontSize.sp16,
                              fontColor: AppColor.grey,
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: AppHeightSize.h2,
                          ),
                      itemCount: titles.length),
                ),
                SizedBox(
                  height: AppHeightSize.h3,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        text: privacyPolicyDate,
                        fontSize: AppFontSize.sp16,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColor.grey,
                      ),
                    ],
                  ),
                ),
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
