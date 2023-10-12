import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/identitas_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IdentitasSection(),
                    ));
              },
              child: Container(
                height: 150,
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        colors: [primaryColor, first],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ayo Isi Kuisioner !",
                          style: MyFont.poppins(
                              fontSize: 18,
                              color: white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Verifikasi akun anda dan bantu rekan alumni untuk mengetahui track record anda",
                          style: MyFont.poppins(fontSize: 12, color: white),
                        ),
                        Image.asset(
                          "images/logowhite.png",
                          height: 40,
                        ),
                      ],
                    )),
                    // SvgPicture.asset(
                    //   "images/crhd.svg",
                    // )
                    Image.asset(
                      "images/logowhite.png",
                      height: 100,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
