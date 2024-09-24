import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';

class TitleTextField extends StatefulWidget {
  TitleTextField(
      {super.key,
      required this.title,
      required this.hint,
      this.isPasswordField = false,
      required this.controller,
      required this.formKey,
      this.validator,
      this.textInputType,
      this.passwordVisible = false});

  final String title, hint;
  final bool isPasswordField;
  bool passwordVisible;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final TextInputType? textInputType;
  String? Function(String?)? validator;

  @override
  State<TitleTextField> createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends State<TitleTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: widget.title,
          fontSize: AppFontSize.sp16,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: AppHeightSize.h2,
        ),
        Form(
          key: widget.formKey,
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPasswordField == true
                ? !widget.passwordVisible
                : false,
            validator: widget.validator,
            keyboardType: widget.textInputType,
            decoration: InputDecoration(
                hintText: widget.hint,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: AppWidthSize.w3point8,
                    vertical: AppHeightSize.h1point5),
                suffixIcon: widget.isPasswordField == false
                    ? null
                    : IconButton(
                        icon: Icon(
                          widget.passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: widget.passwordVisible
                              ? AppColor.purple
                              : AppColor.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.passwordVisible = !widget.passwordVisible;
                          });
                        },
                      ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.purple, width: 2),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.grey, width: 1),
                ),
                labelStyle: GoogleFonts.ibmPlexSansArabic(
                    color: Colors.black, fontSize: AppFontSize.sp16),
                hintStyle: GoogleFonts.ibmPlexSansArabic(
                    color: Colors.grey, fontSize: AppFontSize.sp16)),
          ),
        )
      ],
    );
  }
}
