import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';

class PhoneNumberWidget extends StatelessWidget {
  PhoneNumberWidget(
      {super.key,
      this.isOnlySA = true,
      required this.formKey,
      required this.onPhoneNumberChanged});

  final PhoneNumber phoneNumber = PhoneNumber(isoCode: "SA");
  final bool isOnlySA;
  final Function(String) onPhoneNumberChanged;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Form(
        key: formKey,
        child: InternationalPhoneNumberInput(
          onInputChanged: (value) {
            onPhoneNumberChanged(value.phoneNumber ?? "");
          },
          onFieldSubmitted: (value) {
            onPhoneNumberChanged(value);
          },
          autoValidateMode: AutovalidateMode.onUserInteraction,
          inputDecoration: InputDecoration(
            fillColor: AppColor.white,
            focusColor: AppColor.darkOrange,
            hintStyle: GoogleFonts.ibmPlexSansArabic(
              color: AppColor.grey,
              fontSize: AppFontSize.sp16,
              fontWeight: FontWeight.bold,
            ),
            labelStyle: GoogleFonts.ibmPlexSansArabic(
              color: AppColor.black,
              fontSize: AppFontSize.sp16,
              fontWeight: FontWeight.bold,
            ),
            errorStyle: GoogleFonts.ibmPlexSansArabic(
              fontSize: AppFontSize.sp14,
            ),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  color: AppColor.grey1,
                )),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                )),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  color: AppColor.purple,
                )),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                )),
          ),
          inputBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Colors.transparent,
                // color: Colors.transparent,
              )),
          hintText: '000 000 000',
          validator: (value) {
            if ((value ?? "").isEmpty) {
              return "emptyField".tr();
            }
            // if((value??"").isValidPhoneNumber()){
            //   return "pleaseEnterValidPhoneNumber".tr();
            // }
            return null;
          },
          keyboardType: TextInputType.phone,
          scrollPadding: const EdgeInsets.all(1),
          countrySelectorScrollControlled: true,
          textStyle:
              TextStyle(color: AppColor.black, fontSize: AppFontSize.sp16),
          textAlign: TextAlign.left,
          initialValue: phoneNumber,
          countries: isOnlySA == true ? const ['SA'] : null,
          keyboardAction: TextInputAction.done,
          cursorColor: AppColor.purple,
          maxLength: 15,
          selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              leadingPadding: AppWidthSize.w5,
              trailingSpace: false,
              showFlags: true,
              useBottomSheetSafeArea: true,
              setSelectorButtonAsPrefixIcon: true),
        ),
      ),
    );
  }
}
