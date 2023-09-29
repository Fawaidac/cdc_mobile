import 'dart:io';

import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Posting extends StatefulWidget {
  const Posting({super.key});

  @override
  State<Posting> createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  File? image;
  var keterangan = TextEditingController();
  Future getImageGalery() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(imageFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              "Pilih Gambar",
              style: MyFont.poppins(fontSize: 12, color: black),
            ),
            GestureDetector(
              onTap: () {
                getImageGalery();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    dashPattern: [8, 4],
                    strokeCap: StrokeCap.round,
                    color: black,
                    child: image == null
                        ? Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/photo.png",
                                  height: 40,
                                  color: black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "upload gambar",
                                  style: MyFont.poppins(
                                      fontSize: 12, color: softgrey),
                                )
                              ],
                            ),
                          )
                        : Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: FileImage(image!),
                                    fit: BoxFit.cover)),
                          )),
              ),
            ),
            Text(
              "Tambah Keterangan",
              style: MyFont.poppins(fontSize: 12, color: black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    maxLines: 5,
                    controller: keterangan,
                    style: MyFont.poppins(fontSize: 13, color: black),
                    keyboardType: TextInputType.text,
                    onSaved: (val) => keterangan = val as TextEditingController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    decoration: InputDecoration(
                      hintText: "Keterangan ...",
                      isDense: true,
                      hintStyle: GoogleFonts.poppins(fontSize: 13, color: grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xffC4C4C4).withOpacity(0.2),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
