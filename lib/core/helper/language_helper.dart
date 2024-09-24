import '../storage/shared_pref/shared_preferences.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/30/2024.
 */

abstract class LanguageHelper {
  static bool isEnglishAppLanguage() {
    return AppSharedPreferences.getAppLanguageCode() == 'en';
  }

  static bool isEnglishData({required String data}) {
    if (data.isEmpty) return isEnglishAppLanguage();

    data = data.replaceAll(RegExp(r'[^\w\u0600-\u06FF\s]'), '');

    bool isOk = data.trim().startsWith(RegExp(r'[A-Za-z]'), 0);
    return isOk;
  }
}
