import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';

class RememberMeCheckBox extends StatefulWidget {
  const RememberMeCheckBox({super.key, required this.onChecked});
  final Function(bool) onChecked;

  @override
  State<RememberMeCheckBox> createState() => _RememberMeCheckBoxState();
}

class _RememberMeCheckBoxState extends State<RememberMeCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChecked(isChecked);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: AppHeightSize.h2,
            height: AppHeightSize.h3,
            child: Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                  widget.onChecked(isChecked);
                });
              },
            ),
          ),
          SizedBox(
            width: AppWidthSize.w1point5,
          ),
          AppText(
            text: "rememberMe".tr(),
            fontSize: AppFontSize.sp15,
          ),
        ],
      ),
    );
  }
}
