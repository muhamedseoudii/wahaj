import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';

/**
 * Created by Eng.Eyad AlSayed on 4/24/2024.
 */

abstract class FirebaseAnalyticsEvent {
  static String firstAppOpenEvent = "first_app_open";
  static String visitAppEvent = "visit_app";
}

abstract class FirebaseAnalyticsHelper {
  static late FirebaseAnalytics _firebaseAnalytics;
  static late FirebaseAnalyticsObserver firebaseAnalyticsObserver;
  static void init() {
    _firebaseAnalytics = FirebaseAnalytics.instance;
    firebaseAnalyticsObserver =
        FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);
  }

  static Future<void> firstAppOpenEvent() async {
    if (AppSharedPreferences.isFirstAppOpen() == false) return;
    await _firebaseAnalytics.logEvent(
        name: FirebaseAnalyticsEvent.firstAppOpenEvent);
  }

  static Future<void> visitAppEvent() async {
    await _firebaseAnalytics.logEvent(
        name: FirebaseAnalyticsEvent.visitAppEvent);
  }
}
