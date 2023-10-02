import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tentang extends StatelessWidget {
  const Tentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: primaryColor,
            size: 30,
          ),
        ),
        title: Text(
          "Tantang Aplikasi",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Aplikasi CDC Career Development Center adalah solusi yang dirancang oleh Teaching Factory Jurusan Teknologi Informasi Politeknik Negeri Jember untuk membantu mahasiswa dan alumni kami dalam menjalani perjalanan karir mereka. Aplikasi ini menyediakan akses ke berbagai informasi dan layanan yang diperlukan untuk mencapai kesuksesan dalam dunia kerja.",
                    style: MyFont.poppins(fontSize: 12, color: white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Versi Aplikasi: 1.0.0",
              style: MyFont.poppins(fontSize: 12, color: black),
            ),
            Image.asset(
              "images/logogrey.png",
              height: 125,
            ),
            SvgPicture.asset(
              "images/5tentang.svg",
              alignment: Alignment.topCenter,
              width: 700,
              height: MediaQuery.of(context).size.height,
            )
          ],
        ),
      ),
    );
  }
}
