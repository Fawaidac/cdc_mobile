import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cdc_mobile/resource/awesome_dialog.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/screen/login/login_view.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePosting extends StatefulWidget {
  String idPost;
  final String image;
  final String description;
  final String position;
  final String company;
  final String typeJobs;
  final String expired;
  final String linkApply;
  UpdatePosting(
      {required this.idPost,
      required this.image,
      required this.description,
      required this.position,
      required this.company,
      required this.typeJobs,
      required this.expired,
      required this.linkApply,
      super.key});

  @override
  State<UpdatePosting> createState() => _UpdatePostingState();
}

class _UpdatePostingState extends State<UpdatePosting> {
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
  var desc = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tautan.text = widget.linkApply;
    perusahaan.text = widget.company;
    desc.text = widget.description;
    selectedDate = DateTime.parse(widget.expired);
    selectedType = widget.typeJobs;
    posisi.text = widget.position;
  }

  void submitPost() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    String formattedDateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final response = await ApiServices.updatePostUser(
        tautan.text,
        perusahaan.text,
        desc.text,
        formattedDate,
        selectedType.toString(),
        posisi.text,
        formattedDateNow,
        widget.idPost);
    if (response['code'] == 200) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
      Fluttertoast.showToast(msg: "Berhasil memperbarui postingan");
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
          await ApiServices.logout();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginView(),
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
    } else if (response['message'] == "The link must be a valid URL.") {
      Fluttertoast.showToast(msg: "Silahkan isi tautan yang valid");
    } else {
      print(response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            )),
        title: Text(
          "Edit Postingan",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
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
                    controller: desc,
                    style: MyFont.poppins(fontSize: 13, color: black),
                    keyboardType: TextInputType.text,
                    onSaved: (val) => desc = val as TextEditingController,
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
                    submitPost();
                  },
                  child: Text('Perbarui Postingan',
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
