import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200, child: Image.asset("images/onboarding3.png")),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Eksplorasi",
            style: MyFont.poppins(
                fontSize: 14, color: black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Temukan rekan alumni dan jelajahi aplikasi sesuai dengan keinginan anda, share pengalaman, pendidikan, hingga pekerjaan anda terkini.",
              textAlign: TextAlign.center,
              style: MyFont.poppins(fontSize: 12, color: black),
            ),
          )
        ],
      ),
    ));
  }
}
