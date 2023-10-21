import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cdc_mobile/resource/awesome_dialog.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/screen/login/login.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Posting extends StatefulWidget {
  const Posting({super.key});

  @override
  State<Posting> createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  File? image;
  DateTime? selectedDate;
  final ApiServices apiServices = ApiServices();

  String? selectedType;
  List<String> typeOptions = [
    'Purnawaktu',
    'Paruh Waktu',
    'Wiraswasta',
    'Pekerja Lepas',
    'Kontrak',
    'Musiman',
  ];

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
  var tautan = TextEditingController();
  var keterangan = TextEditingController();

  void check() {
    if (image == null) {
      Fluttertoast.showToast(msg: "Silahkan pilih gambar");
    } else {
      submitPost();
    }
  }

  void submitPost() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    final response = await ApiServices.post(
        image: image!,
        linkApply: tautan.text,
        company: perusahaan.text,
        description: keterangan.text,
        expired: formattedDate,
        typeJob: selectedType.toString(),
        position: posisi.text);
    if (response['code'] == 201) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
      Fluttertoast.showToast(
          msg:
              "Berhasil mengunggah postingan, mohon menunggu verifikasi dari admin");
    } else if (response['message'] ==
        'your token is not valid , please login again') {
      // ignore: use_build_context_synchronously
      GetAwesomeDialog.showCustomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: "Error",
        isTouch: false,
        desc: "Sesi anda telah habis, cob alogin ulang",
        btnOkPress: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.remove('token');
          preferences.remove('tokenExpirationTime');
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ));
        },
        btnCancelPress: () => Navigator.pop(context),
      );
    } else if (response['message'] ==
        "ops , nampaknya akun kamu belum terverifikasi") {
      // ignore: use_build_context_synchronously
      GetAwesomeDialog.showCustomDialog(
        isTouch: false,
        context: context,
        dialogType: DialogType.ERROR,
        title: "Error",
        desc:
            "ops , nampaknya akun kamu belum terverifikasi, Silahkan isi quisioner terlebih dahulu",
        btnOkPress: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        },
        btnCancelPress: () => Navigator.pop(context),
      );
      print('Account is not verified');
    } else {
      print(response['message']);
    }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Tambah Keterangan",
                    style: MyFont.poppins(fontSize: 12, color: black),
                  ),
                ),
                Text(
                  "*",
                  style: MyFont.poppins(fontSize: 12, color: red),
                )
              ],
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
                        label: "Nama Posisi",
                        isRequired: true,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Jenis Pekerjaan",
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),
                      Text(
                        "*",
                        style: MyFont.poppins(fontSize: 12, color: red),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: DropdownButtonFormField<String>(
                    value: selectedType,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: black,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        selectedType = newValue;
                      });
                    },
                    items: typeOptions.map((v) {
                      return DropdownMenuItem<String>(
                        value: v,
                        child: Text(
                          v,
                          style: MyFont.poppins(fontSize: 12, color: black),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: "Pilih",
                      isDense: true,
                      hintStyle: GoogleFonts.poppins(fontSize: 13, color: grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFCFDFE),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Tanggal Tutup",
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ),
                  Text(
                    "*",
                    style: MyFont.poppins(fontSize: 12, color: red),
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
                    check();
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
