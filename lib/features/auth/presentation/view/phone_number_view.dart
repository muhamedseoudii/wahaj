import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/auth/presentation/cubit/send_code_cubit/send_code_cubit.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/widget/snack_bar/note_message.dart';
import '../screen/verification_code_screen.dart';
import '../widget/phone_number_widget.dart';

class PhoneNumberView extends StatefulWidget {
  const PhoneNumberView({super.key});

  @override
  State<PhoneNumberView> createState() => _PhoneNumberViewState();
}

class _PhoneNumberViewState extends State<PhoneNumberView> {
  String phoneNumber = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppHeightSize.h1,
            ),
            AppText(
              text: "phoneNumber".tr(),
              fontSize: AppFontSize.sp16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            PhoneNumberWidget(
                formKey: formKey,
                onPhoneNumberChanged: (value) {
                  phoneNumber = value;
                }),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            BlocConsumer<SendCodeCubit, SendCodeState>(
              listener: (context, state) {
                if (state.status == CubitStatus.error) {
                  NoteMessage.showErrorSnackBar(
                      context: context, text: state.model.error ?? "");
                }
                if (state.status == CubitStatus.success) {
                  Navigator.of(context).pushNamed(RouteName.verifyCode,
                      arguments: VerificationCodeArgs(
                          phoneNumber: phoneNumber,
                          verificationId:
                              state.model.data?['verificationId'] ?? ""));
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
                            .read<SendCodeCubit>()
                            .sendCode(body: {"phone_number": phoneNumber});
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
                        SizedBox(
                          height: AppHeightSize.h2,
                        ),
                        AppText(
                          text: "getVerifyCode".tr(),
                          fontSize: AppFontSize.sp15,
                          fontColor: AppColor.white,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: AppHeightSize.h2,
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
  }
}
