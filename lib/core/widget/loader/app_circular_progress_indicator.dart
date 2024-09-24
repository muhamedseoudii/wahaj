import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  AppCircularProgressIndicator({super.key, this.loadingColor});

  Color? loadingColor;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: loadingColor ?? AppColor.purple,
    );
  }
}
