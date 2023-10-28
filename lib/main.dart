import 'package:cdc_mobile/services/notification_services.dart';
import 'package:cdc_mobile/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  // Notifikasi diterima saat aplikasi ditutup (terminated)
  print(
      "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.title}");
  print(
      "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.body}");
  LocalNotificationsServices.showNotificationForeground(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  LocalNotificationsServices.initialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void configureFirebaseMessaging() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Notifikasi diterima saat aplikasi dibuka dari background (terminated)
        print(
            "Notifikasi diterima saat aplikasi dibuka dari background (terminated): ${message.notification?.title}");
        print(
            "Notifikasi diterima saat aplikasi dibuka dari background (terminated): ${message.notification?.body}");
        LocalNotificationsServices.showNotificationForeground(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Notifikasi diterima saat aplikasi berjalan di foreground
      print(
          "Notifikasi diterima saat aplikasi berjalan di foreground: ${message.notification?.title}");
      print(
          "Notifikasi diterima saat aplikasi berjalan di foreground: ${message.notification?.body}");
      LocalNotificationsServices.showNotificationForeground(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Notifikasi diterima saat aplikasi dibuka dari background (background running)
      print(
          "Notifikasi diterima saat aplikasi dibuka dari background (background running): ${message.notification?.title}");
      print(
          "Notifikasi diterima saat aplikasi dibuka dari background (background running): ${message.notification?.body}");
      LocalNotificationsServices.showNotificationForeground(message);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SplashScreen(),
          ));
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  Future<void> fcm() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }

  Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    // Notifikasi diterima saat aplikasi ditutup (terminated)
    print(
        "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.title}");
    print(
        "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.body}");
    LocalNotificationsServices.showNotificationForeground(message);
  }

  @override
  void initState() {
    super.initState();
    configureFirebaseMessaging();
    fcm();
    LocalNotificationsServices.initialized();
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cdc Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
