import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/screen/login/login_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
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

        Fluttertoast.showToast(msg: response['message']);
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
