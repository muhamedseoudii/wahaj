import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import '../../../../../core/resource/app_color.dart';
import '../../../../../core/resource/app_size.dart';
import '../../../../../core/resource/cubit_status.dart';
import '../../../../../core/widget/loader/app_circular_progress_indicator.dart';
import '../../../../../core/widget/snack_bar/note_message.dart';
import '../../../../../core/widget/text/app_text.dart';
import '../../../../../router/app_router.dart';
import '../../cubit/sign_cubit/sign_cubit.dart';
import '../title_text_field.dart';

void showSignUpDialog({required BuildContext context}) {
  List<TextEditingController> controllers =
      List.generate(2, (index) => TextEditingController());
  List<GlobalKey<FormState>> formKeys =
      List.generate(2, (index) => GlobalKey<FormState>());

  bool isValidInput() {
    bool isOk = true;
    for (GlobalKey<FormState> element in formKeys) {
      isOk &= element.currentState?.validate() ?? false;
    }
    return isOk;
  }

  Dialog dialog = Dialog(
    backgroundColor: AppColor.white,
    surfaceTintColor: AppColor.white,
    insetPadding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextField(
              controller: controllers[0],
              formKey: formKeys[0],
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if ((value ?? "").isEmpty) {
                  return "emptyField".tr();
                }
                return null;
              },
              title: "email".tr(),
              hint: "email".tr(),
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            TitleTextField(
              isPasswordField: true,
              controller: controllers[1],
              formKey: formKeys[1],
              title: "password".tr(),
              hint: "password".tr(),
              validator: (value) {
                if ((value ?? "").isEmpty) {
                  return "emptyField".tr();
                }
                return null;
              },
            ),
            SizedBox(
              height: AppHeightSize.h1point8,
            ),
            RichText(
              text: TextSpan(
                text: "signUpArgument".tr(),
                style: LanguageHelper.isEnglishAppLanguage()
                    ? GoogleFonts.ibmPlexSans(
                        fontSize: AppFontSize.sp15,
                        color: AppColor.grey,
                      )
                    : GoogleFonts.ibmPlexSansArabic(
                        fontSize: AppFontSize.sp15,
                        color: AppColor.grey,
                      ),
                children: <TextSpan>[
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context)
                            .pushNamed(RouteName.privacyPolicy);
                      },
                    text: 'privacyPolicy'.tr(),
                    style: LanguageHelper.isEnglishAppLanguage()
                        ? GoogleFonts.ibmPlexSans(
                            fontSize: AppFontSize.sp16,
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          )
                        : GoogleFonts.ibmPlexSansArabic(
                            fontSize: AppFontSize.sp16,
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            BlocConsumer<SignUpCubit, SignState>(
              listener: (context, state) {
                if (state.status == CubitStatus.error) {
                  NoteMessage.showErrorSnackBar(
                      context: context, text: state.model.error ?? "");
                }
                if (state.status == CubitStatus.success) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteName.main, (route) => false);
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
                      if (isValidInput()) {
                        context.read<SignUpCubit>().signUp(body: {
                          "email": controllers[0].text,
                          "password": controllers[1].text
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
                        SizedBox(
                          height: AppHeightSize.h2,
                        ),
                        AppText(
                          text: "signup".tr(),
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
          ],
        ),
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (context) => BlocProvider(
      create: (context) => SignUpCubit(),
      child: dialog,
    ),
  );
}
