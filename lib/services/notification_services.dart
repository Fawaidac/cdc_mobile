import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsServices {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void initialized() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    notificationsPlugin.initialize(initializationSettings);
  }

  static void showNotificationForeground(RemoteMessage message) {
    final notificationsDetail = NotificationDetails(
        android: AndroidNotificationDetails(
            "com.jtiinovation.cdc_mobile", "Cdc-Online",
            importance: Importance.max, priority: Priority.high));
    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    notificationsPlugin.show(notificationId, message.notification!.title,
        message.notification!.body, notificationsDetail);
  }
}
