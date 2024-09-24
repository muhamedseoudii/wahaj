import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/firebase/helper/firebase_analytics_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_image.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';
import 'package:mo_wahaj_top/features/intro/cubit/launch_type_cubit/launch_type_cubit.dart';
import 'package:mo_wahaj_top/router/app_router.dart';
import '../../../../core/widget/snack_bar/note_message.dart';

/**
 * Created by Eng.Eyad AlSayed on 4/23/2024.
 */

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FirebaseAnalyticsHelper.firstAppOpenEvent();
    FirebaseAnalyticsHelper.visitAppEvent();
    AppSharedPreferences.seFirstAppOpen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LaunchTypeCubit, LaunchTypeState>(
        listener: (context, state) {
          if(state.status == CubitStatus.error){
            NoteMessage.showErrorSnackBar(context: context, text: state.model.error??"");
          }
          if (state.status == CubitStatus.success) {
            openNextScreen(
                code: state.model.data?[
                        Platform.isAndroid ? 'first_type' : 'second_type'] ??
                    0);
          }
        },
        builder: (context, state) {
          return Center(
            child: Image.asset(
              AppImage.newAppIcon2,
              width: AppWidthSize.w80,
              height: AppHeightSize.h80,
            ),
          );
        },
      ),
    );
  }

  void openNextScreen({required String code}) {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (code == "00") {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.webView, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.main, (route) => false);
        }
      },
    );
  }
}
