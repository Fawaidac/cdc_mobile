import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/home/fasilitas/whatsapp_view.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_quisioner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Fasilitas extends StatefulWidget {
  const Fasilitas({super.key});

  @override
  State<Fasilitas> createState() => _FasilitasState();
}

class _FasilitasState extends State<Fasilitas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: primaryColor,
          ),
        ),
        title: Text(
          "Fasilitas",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetQuisioner(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GrupWhatsappView(),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                height: 175,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      colors: [Color(0xff17b9a4), Color(0xff8bebd7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        height: 120,
                        child: Image.asset(
                          "images/face.png",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Grup Whatsapp",
                            style: MyFont.poppins(
                                fontSize: 20,
                                color: white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Cari relasi anda berdasarkan\nkota tempat kelahiran anda",
                            style: MyFont.poppins(
                                fontSize: 12,
                                color: white,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
