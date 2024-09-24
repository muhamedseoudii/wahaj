import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../firebase_options.dart';
import '../../helper/flutter_local_notification.dart';

/**
 * Created by Eng.Eyad AlSayed on 4/23/2024.
 */

abstract class FirebaseHelper {
  static final List<String> publicTopics = ["Public", "all"];

  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      criticalAlert: true,
    );

    startListen();
  }

  static Future<void> startListen() async {
    startListenToTopics();
    startListenToForeground();
    startListToBackground();
  }

  static void startListenToForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      FlutterLocalNotification.createNotification(
          message: message, name: "Foreground");
    });
  }

  @pragma('vm:entry-point')
  static void startListToBackground() {
    FirebaseMessaging.onBackgroundMessage(backgroundNotificationListener);
  }

  @pragma('vm:entry-point')
  static Future<void> backgroundNotificationListener(
      RemoteMessage message) async {
    // FlutterLocalNotificationHelper.createNotification(
    //     message: message, name: "Background");
  }

  static void startListenToTopics() {
    for (String element in publicTopics) {
      FirebaseMessaging.instance.subscribeToTopic(element);
    }
  }
}
