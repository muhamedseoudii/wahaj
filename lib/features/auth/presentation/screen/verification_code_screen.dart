// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;

import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/router/app_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/helper/language_helper.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_icon.dart';
import '../../../../core/resource/app_image.dart';
import '../../../../core/resource/cubit_status.dart';
import '../../../../core/widget/snack_bar/note_message.dart';
import '../cubit/verifiy_code_cubit/verifiy_code_cubit.dart';
import '../widget/resend_verification_widget.dart';
import '../widget/verification_digit_widget.dart';

class VerificationCodeArgs {
  String verificationId;
  String phoneNumber;

  VerificationCodeArgs(
      {required this.verificationId, required this.phoneNumber});
}

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key, required this.args});
  final VerificationCodeArgs args;

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  String code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w4),
          child: Column(
            children: [
              SizedBox(
                height: AppHeightSize.h7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                        LanguageHelper.isEnglishAppLanguage()
                            ? AppIcon.arrowRight
                            : AppIcon.arrowLeft,
                        colorFilter: const ColorFilter.mode(
                            AppColor.black, BlendMode.srcIn)),
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightSize.h8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImage.newAppIcon2,
                    width: AppWidthSize.w80,
                    height: 30.h,
                  ),
                ],
              ),
              SizedBox(
                height: AppHeightSize.h4,
              ),
              AppText(
                text: "verifyCode".tr(),
                fontSize: AppFontSize.sp18,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: AppHeightSize.h1,
              ),
              RichText(
                softWrap: true,
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "enterVerificationCode".tr(),
                  style: LanguageHelper.isEnglishAppLanguage()
                      ? GoogleFonts.ibmPlexSans(
                          fontSize: AppFontSize.sp16,
                          color: AppColor.grey,
                        )
                      : GoogleFonts.ibmPlexSansArabic(
                          fontSize: AppFontSize.sp16,
                          color: AppColor.grey,
                        ),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            " ${widget.args.phoneNumber.replaceAll("+", "")}+",
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: AppFontSize.sp16,
                            color: AppColor.purple,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              SizedBox(
                height: AppHeightSize.h4,
              ),
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: VerificationCodeWidget(
                  onCodeChanged: (value) {
                    code = value;
                  },
                  onCodeEntered: (value) {
                    if (value.length != 6) return;
                    context.read<VerifyCodeCubit>().verifyCode(body: {
                      "verificationId": widget.args.verificationId,
                      "otp": code,
                    });
                  },
                ),
              ),
              SizedBox(
                height: AppHeightSize.h5,
              ),
              BlocConsumer<VerifyCodeCubit, VerifiyCodeState>(
                listener: (context, state) {
                  if (state.status == CubitStatus.error) {
                    NoteMessage.showErrorSnackBar(
                        context: context, text: state.model.error??"");
                  }
                  if (state.status == CubitStatus.success) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteName.main, (route) => false);
                  }
                },
                builder: (context, state) {
                  if (state.status == CubitStatus.loading) {
                    return Center(child: AppCircularProgressIndicator());
                  }

                  return SizedBox(
                    width: AppWidthSize.w80,
                    child: ElevatedButton(
                        onPressed: () {
                          if (code.length != 6) return;

                          context.read<VerifyCodeCubit>().verifyCode(body: {
                            "verificationId": widget.args.verificationId,
                            "phone_number": widget.args.phoneNumber,
                            "otp": code,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.purple,
                            surfaceTintColor: AppColor.purple,
                            padding: EdgeInsets.symmetric(
                                horizontal: AppWidthSize.w3point8,
                                vertical: AppHeightSize.h2),
                            textStyle: const TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: AppText(
                          text: "verify".tr(),
                          fontSize: AppFontSize.sp15,
                          fontColor: AppColor.white,
                          fontWeight: FontWeight.w500,
                        )),
                  );
                },
              ),
              SizedBox(
                height: AppHeightSize.h2,
              ),
              ResendVerificationWidget(
                phoneNumber: widget.args.phoneNumber,
              )
            ],
          ),
        ),
      ),
    );
  }
}
