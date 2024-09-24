import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
/**
 * Created by Eng.Eyad AlSayed on 4/23/2024.
 */

abstract class FlutterLocalNotification {
  static late InitializationSettings initializationSettings;
  static late AndroidNotificationDetails androidNotificationDetails;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void createNotification(
      {required RemoteMessage message, required String name}) {
    Map<String, dynamic> data = message.data;

    showNotification(
        notificationId: message.hashCode,
        title: data["title"] ?? message.notification?.title ?? "Wahaj - وهـج",
        body: data["body"] ?? message.notification?.body ?? "Wahaj - وهـج",
        payload: data["payload"],
        notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
                "wahaj_cha_id", "wahaj_cha_name",
                channelDescription: "wahaj_cha_desc",
                importance: Importance.high,
                playSound: true,
                enableVibration: true,
                icon: "@drawable/app_icon")));
  }

  static Future<void> showNotification(
      {required int notificationId,
      String? title,
      String? body,
      String? payload,
      required NotificationDetails notificationDetails}) async {
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  static Future<void> init() async {
    initializationSettings = const InitializationSettings(
        android: AndroidInitializationSettings("@drawable/app_icon"),
        iOS: DarwinInitializationSettings());

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }
}
