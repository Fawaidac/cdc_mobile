import 'dart:io';

import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:cdc_mobile/screen/aktifasi_akun/aktifasi_akun_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class AktifasiAkunView extends StatefulWidget {
  const AktifasiAkunView({super.key});

  @override
  State<AktifasiAkunView> createState() => _AktifasiAkunViewState();
}

class _AktifasiAkunViewState extends State<AktifasiAkunView> {
  var nama = TextEditingController();
  var email = TextEditingController();
  var nim = TextEditingController();
  var telp = TextEditingController();
  var tempatlahir = TextEditingController();
  var alamat = TextEditingController();
  var gender = TextEditingController();
  var jurusan = TextEditingController();
  var prodi = TextEditingController();
  var tahunlulus = TextEditingController();
  var angkatan = TextEditingController();

  DateTime? selectedDate;

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

  Future pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Anda dapat menyesuaikan tipe file yang diizinkan
      allowedExtensions: [
        'pdf',
      ], // Izinkan ekstensi yang Anda inginkan
    );
    if (result != null) {
      final filePath =
          result.paths.first; // Get the first selected file path if available
      if (filePath != null) {
        setState(() {
          // Use filePath which is guaranteed to be non-null
          pdf = File(filePath);
          // You can proceed with the file now
        });
      } else {
        // Handle the case when the user selected no files
      }
    } else {
      // Handle the case when the user canceled the file selection
    }
  }

  String? selectedJenisKelamin;

  List<String> chooseOptions = [
    'Laki-Laki',
    'Perempuan',
  ];

  File? pdf;

  final controller = AktifasiAkunController();
  void check() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);

    if (pdf == null) {
      Fluttertoast.showToast(
          msg: "Silahkan upload ijazah anda dengan format pdf");
    } else {
      await controller.sendAktifasiAkun(
          pdf!,
          nama.text,
          email.text,
          nim.text,
          telp.text,
          tempatlahir.text,
          formattedDate,
          alamat.text,
          selectedJenisKelamin.toString(),
          jurusan.text,
          prodi.text,
          tahunlulus.text,
          angkatan.text,
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                "Pengajuan Aktifasi",
                style: MyFont.poppins(
                    fontSize: 24, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Masukan data diri anda dengan benar",
                style: MyFont.poppins(fontSize: 12, color: black),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: nama,
                  label: "Nama Lengkap",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.person),
              CustomTextField(
                  controller: email,
                  label: "Email",
                  isEnable: true,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.mail),
              CustomTextField(
                  controller: telp,
                  label: "No.Telepon",
                  isEnable: true,
                  keyboardType: TextInputType.number,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  isLength: 13,
                  icon: Icons.phone),
              CustomTextField(
                  controller: nim,
                  label: "NIM (Nomor Induk Mahasiswa)",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  isLength: 10,
                  icon: Icons.badge),
              CustomTextField(
                  controller: tempatlahir,
                  label: "Tempat Lahir",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.location_city),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffC4C4C4).withOpacity(0.2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        selectedDate == null
                            ? "Tanggal Lahir"
                            : "${selectedDate?.toLocal()}".split(' ')[0],
                        style: MyFont.poppins(
                            fontSize: 13,
                            color: selectedDate == null ? grey : black),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: grey,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              CustomTextField(
                  controller: alamat,
                  label: "Alamat Domisili",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.location_city),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: DropdownButtonFormField<String>(
                        value: selectedJenisKelamin,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: grey,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedJenisKelamin = newValue;
                          });
                        },
                        items: chooseOptions.map((v) {
                          return DropdownMenuItem<String>(
                            value: v,
                            child: Text(
                              v,
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih Jenis Kelamin",
                          isDense: true,
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 13, color: grey),
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
                      ),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                  controller: jurusan,
                  label: "Jurusan",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.school),
              CustomTextField(
                  controller: prodi,
                  label: "Program Studi",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.school),
              CustomTextField(
                  controller: angkatan,
                  label: "Tahun Masuk",
                  isEnable: true,
                  keyboardType: TextInputType.number,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  isLength: 4,
                  icon: Icons.calendar_month),
              CustomTextField(
                  controller: tahunlulus,
                  label: "Tahun Lulus",
                  isEnable: true,
                  keyboardType: TextInputType.number,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  isLength: 4,
                  icon: Icons.calendar_month),
              GestureDetector(
                onTap: () {
                  pickAndUploadFile();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      dashPattern: [8, 4],
                      strokeCap: StrokeCap.round,
                      color: black,
                      child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: pdf == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/file.png",
                                      height: 40,
                                      color: black,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Upload Ijazah (PDF)",
                                      style: MyFont.poppins(
                                          fontSize: 12, color: softgrey),
                                    )
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/pdf.png",
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      pdf!.path.split('/').last,
                                      style: MyFont.poppins(
                                          fontSize: 12, color: softgrey),
                                    )
                                  ],
                                ))),
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 15),
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [second, first]),
                      borderRadius: BorderRadius.circular(15)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () {
                      check();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ajukan',
                            style: MyFont.poppins(
                              fontSize: 14,
                              color: white,
                            )),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: white,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
