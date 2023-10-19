import 'dart:io';

import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
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
  DateTime? selectedDate;

  var keterangan = TextEditingController();
  Future getImageGalery() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(imageFile!.path);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2200),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  var posisi = TextEditingController();
  var perusahaan = TextEditingController();
  var lokasi = TextEditingController();
  var jenisPekerjaan = TextEditingController();
  var tautan = TextEditingController();
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
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFFCFDFE),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomTextFieldForm(
                        isEnable: true,
                        controller: posisi,
                        isRequired: true,
                        label: "Nama Posisi",
                        keyboardType: TextInputType.name,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomTextFieldForm(
                        isEnable: true,
                        controller: perusahaan,
                        label: "Nama Perusahaan",
                        isRequired: true,
                        keyboardType: TextInputType.name,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: CustomTextFieldForm(
                        isEnable: true,
                        controller: lokasi,
                        isRequired: true,
                        label: "Lokasi",
                        keyboardType: TextInputType.name,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomTextFieldForm(
                        isEnable: true,
                        controller: jenisPekerjaan,
                        isRequired: true,
                        label: "Jenis Pekerjaan",
                        keyboardType: TextInputType.name,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Tanggal Tutup",
                    style: GoogleFonts.poppins(fontSize: 12),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 48,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    selectedDate == null
                        ? "yyyy/MM/dd"
                        : "${selectedDate?.toLocal()}".split(' ')[0],
                    style: MyFont.poppins(fontSize: 13, color: black),
                  )),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: black,
                    ),
                  )
                ],
              ),
            ),
            CustomTextFieldForm(
                isEnable: true,
                controller: tautan,
                isRequired: true,
                label: "Tautan",
                keyboardType: TextInputType.name,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "*",
                  style: MyFont.poppins(fontSize: 14, color: red),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Wajib Isi",
                  style: MyFont.poppins(fontSize: 14, color: black),
                )
              ],
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 25),
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    // checkLogin();
                  },
                  child: Text('Unggah',
                      style: MyFont.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: white,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
