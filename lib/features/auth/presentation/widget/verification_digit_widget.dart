import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/resource/app_color.dart';

class VerificationCodeWidget extends StatefulWidget {
  final Function(String) onCodeEntered;
  final Function(String) onCodeChanged;

  const VerificationCodeWidget(
      {super.key, required this.onCodeEntered, required this.onCodeChanged});

  @override
  _VerificationCodeWidgetState createState() => _VerificationCodeWidgetState();
}

class _VerificationCodeWidgetState extends State<VerificationCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Pinput(
        autofocus: true,
        keyboardType: TextInputType.number,
        onCompleted: widget.onCodeEntered,
        onChanged: widget.onCodeChanged,
        length: 6,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        defaultPinTheme: PinTheme(
            textStyle: TextStyle(fontSize: AppFontSize.sp16),
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(color: AppColor.lightGrey),
              borderRadius: BorderRadius.circular(10),
            ),
            height: AppHeightSize.h7,
            width: AppWidthSize.w25),
      ),
    );
  }
}
