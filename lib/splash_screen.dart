import 'dart:async';

import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/screen/intro/onboarding.dart';
import 'package:cdc_mobile/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var tokenExpirationTime = preferences.getInt('tokenExpirationTime');

    if (token != null && tokenExpirationTime != null) {
      DateTime expirationDateTime =
          DateTime.fromMillisecondsSinceEpoch(tokenExpirationTime);
      DateTime currentDateTime = DateTime.now();

      if (currentDateTime.isBefore(expirationDateTime)) {
        // Token masih valid, arahkan ke HomePage
        print(expirationDateTime);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        // Token sudah kedaluwarsa, hapus token dan arahkan ke LoginScreen
        preferences.remove('token');
        preferences.remove('tokenExpirationTime');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnBoarding(),
          ),
        );
      }
    } else {
      // Token tidak tersimpan, arahkan ke LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoarding(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: [second, first])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/logowhite.png",
              height: 125,
            ),
            const SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(
              color: white,
            )
          ],
        ),
      ),
    );
  }
}
