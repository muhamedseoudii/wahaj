import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/app/wahaj_app.dart';
import 'package:mo_wahaj_top/core/firebase/helper/firebase_analytics_helper.dart';
import 'package:mo_wahaj_top/core/helper/flutter_local_notification.dart';
import 'package:mo_wahaj_top/core/resource/app_const.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/firebase/helper/firebase_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await FirebaseHelper.init();
  FirebaseAnalyticsHelper.init();

  SharedPreferences instance = await SharedPreferences.getInstance();
  AppSharedPreferences.init(instance: instance);

  await FlutterLocalNotification.init();

  runApp(EasyLocalization(
      supportedLocales: const [
        Locale(
          AppConst.arabicLanguageCode,
        ),
        Locale(
          AppConst.englishLanguageCode,
        ),
      ],
      path: AppConst.translationFilesPath,
      fallbackLocale: const Locale(
        AppConst.arabicLanguageCode,
      ),
      startLocale: Locale(AppSharedPreferences.getAppLanguageCode()),
      child: const WahajApp()));
}
