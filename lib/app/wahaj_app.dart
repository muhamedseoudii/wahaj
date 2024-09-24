import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/firebase/helper/firebase_analytics_helper.dart';
import 'package:mo_wahaj_top/router/app_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/**
 * Created by Eng.Eyad AlSayed on 4/23/2024.
 */

/// Updated by Eng.Muhammed Seoudii on 9/21/2024.

final GlobalKey<NavigatorState> myAppKey = GlobalKey<NavigatorState>();

class WahajApp extends StatefulWidget {
  const WahajApp({super.key});

  @override
  State<WahajApp> createState() => _WahajAppState();
}

class _WahajAppState extends State<WahajApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          navigatorKey: myAppKey,
          navigatorObservers: [
            FirebaseAnalyticsHelper.firebaseAnalyticsObserver,
          ],
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          initialRoute: RouteName.init,
          onGenerateRoute: AppRouter.onGenerateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
