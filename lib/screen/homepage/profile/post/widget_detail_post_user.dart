import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:flutter/material.dart';

class WidgetDetailPost extends StatelessWidget {
  final String image;
  final String description;

  const WidgetDetailPost(
      {required this.image, required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            )),
        title: Text(
          "Postingan",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'postDetail',
              transitionOnUserGestures: true,
              child: SizedBox(
                height: 450,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: MyFont.poppins(fontSize: 12, color: black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
