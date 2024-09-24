import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:mo_wahaj_top/features/auth/presentation/widget/title_text_field.dart';

import '../../../../../core/resource/app_color.dart';
import '../../../../../core/widget/snack_bar/note_message.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/14/2024.
 */

void showForgotPasswordBottomSheet({required BuildContext context}) {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => ForgotPasswordCubit(),
          child: Container(
            padding: EdgeInsets.only(
                left: AppWidthSize.w5,
                right: AppWidthSize.w5,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: AppHeightSize.h2,
                ),
                AppText(
                  text: "forgotPassword".tr(),
                  fontSize: AppFontSize.sp16,
                ),
                SizedBox(
                  height: AppHeightSize.h2,
                ),
                TitleTextField(
                    controller: controller,
                    formKey: formKey,
                    validator: (value) {
                      if ((value ?? "").isEmpty) {
                        return "emptyField".tr();
                      }
                      return null;
                    },
                    title: "userNameOrEmailAddress".tr(),
                    hint: "userNameOrEmailAddress".tr()),
                SizedBox(
                  height: AppHeightSize.h3,
                ),
                BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state.status == CubitStatus.error) {
                      NoteMessage.showErrorSnackBar(
                          context: context, text: state.model.error??"");
                    }
                    if (state.status == CubitStatus.success) {
                      Navigator.of(context).pop();
                      NoteMessage.showSuccessSnackBar(
                          context: context, text: "sentSuccessfully".tr());
                    }
                  },
                  builder: (context, state) {
                    if (state.status == CubitStatus.loading) {
                      return Center(
                        child: AppCircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            context
                                .read<ForgotPasswordCubit>()
                                .forgotPassword(body: {
                              "email": controller.text,
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.purple,
                            padding: EdgeInsets.symmetric(
                                horizontal: AppWidthSize.w3point8,
                                vertical: AppHeightSize.h2),
                            textStyle: const TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: "submit".tr(),
                              fontSize: AppFontSize.sp15,
                              fontColor: AppColor.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ));
                  },
                ),
                SizedBox(
                  height: AppHeightSize.h2,
                ),
              ],
            ),
          ),
        );
      });
}
