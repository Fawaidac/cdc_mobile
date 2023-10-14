import 'dart:convert';

import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/furthestudy_section.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSection extends StatefulWidget {
  const MainSection({super.key});

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  String? selectedStatus;
  String? selectedJobs;
  String? selectedMonth;
  String? selectedPendapatan;
  String? selectedAfter;
  String? selectedJenisInstansi;
  String? selectedJabatan;
  String? selectedTingkatan;

  var jenis = TextEditingController();
  var namaPerusahaan = TextEditingController();
  var pendapatan = TextEditingController();

  List<String> statusOptions = [
    'Bekerja (full time/part time)',
    'Belum memungkinkan kerja',
    'Wiraswasta',
    'Melanjutkan Pendidikan',
    'Tidak kerja tapi sedang mencari kerja'
  ];
  List<String> jobsOptions = [
    'Ya',
    'Tidak',
  ];
  List<String> monthOptions = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  List<String> afterOptions = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  List<String> pendapatanOptions = [
    '1.000.000',
    '1.500.000',
    '2.000.000',
    '2.500.000',
    '3.000.000',
    '3.500.000',
    '4.000.000',
    '4.500.000',
    '>5.000.000',
  ];
  List<String> jenisInstansiOptions = [
    'Instansi pemerintah',
    'Organisasi non-profit/Lembaga Swadaya Masyarakat',
    'Perusahaan swasta',
    'Wiraswasta/perusahaan sendiri',
    'BUMN/BUMD',
    'Institusi/Organisasi Multilateral',
    'Lainnya',
  ];
  List<String> jabatanOptions = [
    'Founder',
    'Co-Founder',
    'Staff',
    'Freelance/Kerja Lepas',
  ];
  List<String> tingkatanOptions = [
    'Lokal/wilayah/wiraswasta tidak berbadan hukum',
    'Nasional/wiraswasta berbadan hukum',
    'Multinasional/Internasional',
  ];

  List<Map<String, dynamic>> _provinsiList = [];
  Map<String, dynamic>? _selectedProvinsi;

  List<Map<String, dynamic>> _regencyList = [];
  Map<String, dynamic>? _selectedRegency;

  Future<void> loadProvinsiData() async {
    final String data = await rootBundle.loadString('assets/provinsi.json');
    final List<dynamic> jsonData = json.decode(data);

    setState(() {
      _provinsiList = jsonData.cast<Map<String, dynamic>>();
      _selectedProvinsi = _provinsiList[0];
    });
  }

  Future<void> loadRegencyData() async {
    final String data = await rootBundle.loadString('assets/regency.json');
    final List<dynamic> jsonData = json.decode(data);

    setState(() {
      _regencyList = jsonData.cast<Map<String, dynamic>>();
      _selectedRegency = _regencyList[0];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProvinsiData();
    loadRegencyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white.withOpacity(0.98),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: primaryColor,
          ),
        ),
        title: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudySection(),
                ));
          },
          child: Text(
            "Kuisioner Utama",
            style: MyFont.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Jelaskan status anda saat ini?",
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
                        value: selectedStatus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedStatus = newValue;
                          });
                        },
                        items: statusOptions.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(
                              status,
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih",
                          isDense: true,
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 13, color: grey),
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
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Apakah anda telah mendapat pekerjaan <= 6 bulan / termasuk bekerja sebelum lulus",
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
                        value: selectedJobs,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedJobs = newValue;
                          });
                        },
                        items: jobsOptions.map((jobs) {
                          return DropdownMenuItem<String>(
                            value: jobs,
                            child: Text(
                              jobs,
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih",
                          isDense: true,
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 13, color: grey),
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
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Berapa bulan anda mendapatkan pekerjaan SEBELUM LULUS",
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
                        value: selectedMonth,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedMonth = newValue;
                          });
                        },
                        items: monthOptions.map((month) {
                          return DropdownMenuItem<String>(
                            value: month,
                            child: Text(
                              month,
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih",
                          isDense: true,
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 13, color: grey),
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
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(bottom: 10),
            //   padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
            //   width: MediaQuery.of(context).size.width,
            //   color: white,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 10),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(left: 5),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "Berapa rata-rata pendapatan Anda per bulan ?",
            //                 style: GoogleFonts.poppins(fontSize: 12),
            //               )
            //             ],
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         SizedBox(
            //           height: 50,
            //           child: DropdownButtonFormField<String>(
            //             value: selectedPendapatan,
            //             icon: Icon(
            //               Icons.keyboard_arrow_down_rounded,
            //               color: black,
            //             ),
            //             onChanged: (newValue) {
            //               setState(() {
            //                 selectedPendapatan = newValue;
            //               });
            //             },
            //             items: pendapatanOptions.map((pendapatan) {
            //               return DropdownMenuItem<String>(
            //                 value: pendapatan,
            //                 child: Text(
            //                   pendapatan,
            //                   style: MyFont.poppins(fontSize: 12, color: black),
            //                 ),
            //               );
            //             }).toList(),
            //             decoration: InputDecoration(
            //               hintText: "Pilih",
            //               isDense: true,
            //               hintStyle:
            //                   GoogleFonts.poppins(fontSize: 13, color: grey),
            //               enabledBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(
            //                   color: black,
            //                   width: 1,
            //                 ),
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               focusedBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(
            //                   color: black,
            //                   width: 1,
            //                 ),
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               filled: true,
            //               fillColor: const Color(0xFFFCFDFE),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: pendapatan,
                  isEnable: true,
                  label: "Rata-rata pendapatan perbulan",
                  keyboardType: TextInputType.number,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Berapa bulan anda mendapatkan pekerjaan SETELAH LULUS",
                            style: GoogleFonts.poppins(fontSize: 12),
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
                        value: selectedAfter,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedAfter = newValue;
                          });
                        },
                        items: afterOptions.map((month) {
                          return DropdownMenuItem<String>(
                            value: month,
                            child: Text(
                              month,
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih",
                          isDense: true,
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 13, color: grey),
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
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Dimana lokasi provinsi tempat anda bekerja?",
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
                      child: DropdownButtonFormField<Map<String, dynamic>>(
                        value: _selectedProvinsi,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (Map<String, dynamic>? selectedProvinsi) {
                          setState(() {
                            _selectedProvinsi = selectedProvinsi;
                          });
                        },
                        items:
                            _provinsiList.map((Map<String, dynamic> provinsi) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: provinsi,
                            child: Text(
                              provinsi['province_name'] ?? "",
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih",
                          isDense: true,
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 13, color: grey),
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
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Dimana lokasi kabupaten/kota tempat anda bekerja?",
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
                      child: DropdownButtonFormField<Map<String, dynamic>>(
                        value: _selectedRegency,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (Map<String, dynamic>? selectedRegency) {
                          setState(() {
                            _selectedRegency = selectedRegency;
                          });
                        },
                        items: _regencyList.map((Map<String, dynamic> regency) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: regency,
                            child: Text(
                              regency['kabupaten_kota'] ?? "",
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih",
                          isDense: true,
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 13, color: grey),
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
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Apa jenis perusahaan/instansi/institusi tempat anda bekerja sekarang?",
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
                        value: selectedJenisInstansi,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedJenisInstansi = newValue;
                          });
                        },
                        items: jenisInstansiOptions.map((jenis) {
                          return DropdownMenuItem<String>(
                            value: jenis,
                            child: Text(
                              jenis,
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih",
                          isDense: true,
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 13, color: grey),
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
                    if (selectedJenisInstansi == 'Lainnya')
                      CustomTextFieldForm(
                          controller: jenis,
                          label: "Jenis Instansi",
                          keyboardType: TextInputType.text,
                          isEnable: true,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: namaPerusahaan,
                  isEnable: true,
                  label: "Nama perusahaan/kantor",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Bila Anda berwiraswasta, apa posisi/jabatan Anda saat ini ?",
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
                        value: selectedJabatan,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedJabatan = newValue;
                          });
                        },
                        items: jabatanOptions.map((jabatan) {
                          return DropdownMenuItem<String>(
                            value: jabatan,
                            child: Text(
                              jabatan,
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih",
                          isDense: true,
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 13, color: grey),
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
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Apa tingkatan tempat kerja Anda?",
                            style: GoogleFonts.poppins(fontSize: 12),
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
                        value: selectedTingkatan,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedTingkatan = newValue;
                          });
                        },
                        items: tingkatanOptions.map((tingkatan) {
                          return DropdownMenuItem<String>(
                            value: tingkatan,
                            child: Text(
                              tingkatan,
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih",
                          isDense: true,
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 13, color: grey),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        handleQuisionerMain();
                      },
                      child: Text(
                        "Selanjutnya",
                        style: MyFont.poppins(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleQuisionerMain() async {
    bool less6Value = selectedJobs == "Ya" ? true : false;
    String selectedJenisValue = selectedJenisInstansi == 'Lainnya'
        ? jenis.text
        : selectedJenisInstansi.toString();
    String statusValue = selectedStatus.toString();
    try {
      final response = await ApiServices.quisionerMain(
          statusValue,
          less6Value,
          selectedMonth.toString(),
          pendapatan.text,
          selectedAfter.toString(),
          _selectedProvinsi.toString(),
          _selectedRegency.toString(),
          selectedJenisValue,
          namaPerusahaan.text,
          selectedJabatan.toString(),
          selectedTingkatan.toString());
      if (response['code'] == 201) {
        Fluttertoast.showToast(msg: response['message']);
        print("ok");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudySection(),
            ));
      } else {
        Fluttertoast.showToast(msg: response['message']);
        print(response['message']);
      }
    } catch (e) {
      print(e);
    }
  }
}
