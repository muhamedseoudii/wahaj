import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resource/app_color.dart';
import '../../resource/app_size.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/14/2024.
 */

class OutlineTextFormField extends StatefulWidget {
  OutlineTextFormField({
    super.key,
    required this.focusedBorderColor,
    required this.enabledBorderColor,
    required this.hint,
    this.passwordVisible = false,
    this.isPasswordField = false,
    this.textInputType = TextInputType.text,
    this.validator,
    this.edgeInsets,
    this.textAlign,
    this.textAlignVertical,
    this.controller,
    this.formKey,
  });

  final String hint;
  final Color focusedBorderColor, enabledBorderColor;
  bool passwordVisible, isPasswordField;
  TextInputType textInputType;
  EdgeInsets? edgeInsets;
  TextAlign? textAlign;
  TextAlignVertical? textAlignVertical;
  TextEditingController? controller;
  GlobalKey<FormState>? formKey;
  String? Function(String?)? validator;

  @override
  State<OutlineTextFormField> createState() => _OutlineTextFormFieldState();
}

class _OutlineTextFormFieldState extends State<OutlineTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        obscureText: widget.isPasswordField == true ? !widget.passwordVisible : false,
        keyboardType: widget.textInputType,
        textAlign: widget.textAlign ?? TextAlign.start,
        textAlignVertical: widget.textAlignVertical,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: widget.edgeInsets ??
                EdgeInsets.symmetric(
                    horizontal: AppWidthSize.w3point8,
                    vertical: AppHeightSize.h1point8),
            suffixIcon: widget.isPasswordField == false
                ? null
                : IconButton(
                    icon: Icon(
                      widget.passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: widget.passwordVisible
                          ? widget.enabledBorderColor
                          : AppColor.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.passwordVisible = !widget.passwordVisible;
                      });
                    },
                  ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: widget.focusedBorderColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),

              borderSide:
                  BorderSide(color: widget.enabledBorderColor, width: 1),
            ),
            labelStyle: GoogleFonts.ibmPlexSansArabic(
                color: Colors.black, fontSize: AppFontSize.sp16),
            hintStyle: GoogleFonts.ibmPlexSansArabic(
                color: Colors.grey,
                fontSize: AppFontSize.sp15,
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}
