import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/auth/presentation/cubit/send_code_cubit/send_code_cubit.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/widget/snack_bar/note_message.dart';

class ResendVerificationWidget extends StatefulWidget {
  const ResendVerificationWidget({super.key, required this.phoneNumber});

  final String phoneNumber;
  @override
  _ResendVerificationWidgetState createState() =>
      _ResendVerificationWidgetState();
}

class _ResendVerificationWidgetState extends State<ResendVerificationWidget> {
  int _remainingSeconds = 0;
  StreamSubscription<int>? _timerSubscription;
  final int startTime = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingSeconds = startTime;
    _timerSubscription =
        Stream.periodic(const Duration(seconds: 1), (i) => i).listen((event) {
      setState(() {
        _remainingSeconds = startTime - (event % startTime);
      });
      if (_remainingSeconds == 1) {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    setState(() {
      _remainingSeconds = 0;
    });
  }

  void resetTimer() {
    _stopTimer();
    _startTimer();
  }

  @override
  void dispose() {
    _timerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: '${"didntReceiveAnyCode".tr()} ',
              fontSize: AppFontSize.sp16,
            ),
            BlocConsumer<SendCodeCubit, SendCodeState>(
              listener: (context, state) {
                if (state.status == CubitStatus.error) {
                  NoteMessage.showErrorSnackBar(
                      context: context, text: state.model.error ?? "");
                }
                if (state.status == CubitStatus.success) {
                  _startTimer();
                }
              },
              builder: (context, state) {
                return Visibility(
                  visible: _remainingSeconds == 0,
                  child: InkWell(
                    onTap: () {
                      context
                          .read<SendCodeCubit>()
                          .sendCode(body: {"phone_number": widget.phoneNumber});
                    },
                    child: AppText(
                      text: "resend".tr(),
                      fontColor: AppColor.purple,
                      fontSize: AppFontSize.sp16,
                    ),
                  ),
                );
              },
            )
          ],
        ),
        SizedBox(
          height: AppHeightSize.h1,
        ),
        Visibility(
          visible: _remainingSeconds != 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                overflow: TextOverflow.clip,
                softWrap: true,
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "requestNewCodeIn".tr(),
                  style: LanguageHelper.isEnglishAppLanguage()
                      ? GoogleFonts.ibmPlexSans(
                          fontSize: AppFontSize.sp16,
                          color: AppColor.purple,
                        )
                      : GoogleFonts.ibmPlexSansArabic(
                          fontSize: AppFontSize.sp16,
                          color: AppColor.purple,
                        ),
                  children: <TextSpan>[
                    const TextSpan(text: "  "),
                    TextSpan(
                      text: "$_remainingSeconds ${"second".tr()}",
                      style: LanguageHelper.isEnglishAppLanguage()
                          ? GoogleFonts.ibmPlexSans(
                              fontSize: AppFontSize.sp16,
                              color: AppColor.purple,
                            )
                          : GoogleFonts.ibmPlexSansArabic(
                              fontSize: AppFontSize.sp16,
                              color: AppColor.purple,
                            ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
