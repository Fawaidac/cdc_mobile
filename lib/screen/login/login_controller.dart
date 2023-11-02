import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/screen/login/login_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handleLogin(
      String emailOrNik, String password, BuildContext context) async {
    try {
      final response = await LoginServices.login(emailOrNik, password);
      if (response['code'] == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response['data']['token']);

        DateTime expirationTime = DateTime.now().add(Duration(days: 7));
        prefs.setInt(
            'tokenExpirationTime', expirationTime.millisecondsSinceEpoch);
        // String? fcmToken = await firebaseMessaging.getToken();
        // print(' fcmTOken : $fcmToken');
        // final res = await LoginServices.sendFcmToken(fcmToken!);
        // if (res['code'] == 200) {
        //   print('ok');
        // } else {
        //   print(res['message']);
        // }
        Fluttertoast.showToast(msg: response['message']);
        // await firebaseMessaging.subscribeToTopic('all');

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      } else {
        Fluttertoast.showToast(msg: response['message']);
      }
    } catch (e) {
      print(e);
    }
  }
}
