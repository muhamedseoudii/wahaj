import 'package:shared_preferences/shared_preferences.dart';

/**
 * Created by Eng.Eyad AlSayed on 4/24/2024.
 */
abstract class AppSharedPreferencesKey {
  static const String firstAppOpen = "first-app-open";
  static const String login = "login";
  static const String userName = "username";
  static const String language = "language";
}

abstract class AppSharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static void init({required SharedPreferences instance}) {
    _sharedPreferences = instance;
  }

  static void clear() {
    _sharedPreferences.clear();
  }

  static bool isFirstAppOpen() {
    return _sharedPreferences.getBool(AppSharedPreferencesKey.firstAppOpen) ??
        true;
  }

  static void seFirstAppOpen() {
    _sharedPreferences.setBool(AppSharedPreferencesKey.firstAppOpen, false);
  }

  static bool isLogin() {
    return _sharedPreferences.getBool(AppSharedPreferencesKey.login) ?? false;
  }

  static void setLogin({required bool isLogin}) {
    _sharedPreferences.setBool(AppSharedPreferencesKey.login, isLogin);
  }

  static String getUserName() {
    return _sharedPreferences.getString(AppSharedPreferencesKey.userName) ?? '';
  }

  static void setUserName({required String userName}) {
    _sharedPreferences.setString(AppSharedPreferencesKey.userName, userName);
  }

  static String getAppLanguageCode() {
    return _sharedPreferences.getString(AppSharedPreferencesKey.language) ??
        'ar';
  }

  static void setAppLanguage({required String languageCode}) {
    _sharedPreferences.setString(AppSharedPreferencesKey.language, languageCode);
  }
}
