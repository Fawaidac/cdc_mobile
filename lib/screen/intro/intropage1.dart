import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200, child: Image.asset("images/onboarding1.png")),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Carrer Development Center",
            style: MyFont.poppins(
                fontSize: 14, color: black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "CDC (Carrer Development Center) merupakan aplikasi untuk mengkoneksikan alumni dari Politeknik Negeri Jember",
              textAlign: TextAlign.center,
              style: MyFont.poppins(fontSize: 12, color: black),
            ),
          )
        ],
      ),
    ));
  }
}
