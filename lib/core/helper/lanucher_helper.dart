import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import '../firebase/firebase_core/firestore_method.dart';

/**
 * Created by Eng.Eyad AlSayed on 6/3/2024.
 */

abstract class UrlLauncherHelper {
  static Future<void> makeCall(
      {required String phoneNumber,
      required String activityName,
      required image}) async {
    FireStoreAddMethod.addActivityView(body: {
      'activity_name': activityName,
      'image': image,
      'call_action': true,
    });
    await launchUrl(Uri.parse("tel://$phoneNumber"));
  }

  static Future<void> openWhatsapp(
      {required String phoneNumber,
      required String activityName,
      required image}) async {
    FireStoreAddMethod.addActivityView(body: {
      'activity_name': activityName,
      'image': image,
      'whatsapp_action': true,
    });
    Uri uri = Uri.parse(Platform.isIOS
        ? "https://wa.me/$phoneNumber"
        : "whatsapp://send?phone=$phoneNumber");
    await launchUrl(uri);
  }

  static Future<void> openFacebook(
      {required String pageId,
      required String activityName,
      required image}) async {
    FireStoreAddMethod.addActivityView(body: {
      'activity_name': activityName,
      'image': image,
      'facebook_action': true,
    });
    Uri uri = Uri.parse("https://www.facebook.com/profile.php?id=$pageId");
    await launchUrl(uri);
  }

  static Future<void> openInstagram(
      {required String pageName,
      required String activityName,
      required image}) async {
    FireStoreAddMethod.addActivityView(body: {
      'activity_name': activityName,
      'image': image,
      'instagram_action': true,
    });
    Uri uri = Uri.parse("https://www.instagram.com/$pageName");
    await launchUrl(uri);
  }

  static Future<void> openTiktok(
      {required String url,
      required String activityName,
      required image}) async {
    FireStoreAddMethod.addActivityView(body: {
      'activity_name': activityName,
      'image': image,
      'tiktok_action': true,
    });
    await openUrl(url: url);
  }

  static Future<void> openSnapChat(
      {required String url,
      required String activityName,
      required image}) async {
    FireStoreAddMethod.addActivityView(body: {
      'activity_name': activityName,
      'image': image,
      'snapchat_action': true,
    });
    await openUrl(url: url);
  }

  static Future<void> openUrl({required String url}) async {
    await launchUrl(Uri.parse(url));
  }

  static void openGoogleMap(
      {required double lat,
      required double lon,
      required String activityName,
      required image}) async {
    FireStoreAddMethod.addActivityView(body: {
      'activity_name': activityName,
      'image': image,
      'map_action': true,
    });
    final Uri uri =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    await launchUrl(uri);
  }
}
