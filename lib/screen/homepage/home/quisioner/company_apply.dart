import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/jobsuitability_section.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyApply extends StatefulWidget {
  const CompanyApply({super.key});

  @override
  State<CompanyApply> createState() => _CompanyApplyState();
}

class _CompanyApplyState extends State<CompanyApply> {
  String? selectedBefore;
  String? selectedResponse;
  String? selectedInvite;
  String? selectedActive;

  var lainnya = TextEditingController();
  List<String> chooseOptions = [
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
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
  ];
  List<String> chooseOptions2 = [
    'Tidak',
    'Tidak, tapi saya sedang menunggu hasil lamaran kerja',
    'Ya, saya akan mulai bekerja dalam 2 minggu ke depan',
    'Ya, tapi saya belum pasti akan bekerja dalam 2 minggu ke depan',
    'Lainnya',
  ];
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
                    builder: (context) => JobsuitabilitySection(),
                  ));
            },
            child: Text(
              "Kuisioner Jumlah Perusahaan/Instansi/Institusi",
              style: MyFont.poppins(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                  "Jumlah perusahaan/instansi/institusi yang sudah anda lamar (lewat surat atau e-mail)",
                  style: MyFont.poppins(fontSize: 12, color: black),
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
                                "Berapa perusahaan/instansi/institusi yang sudah anda lamar (lewat surat atau e-mail) sebelum anda memperoleh pekerjaan pertama?",
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
                          value: selectedBefore,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedBefore = newValue;
                            });
                          },
                          items: chooseOptions.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style:
                                    MyFont.poppins(fontSize: 12, color: black),
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
                                "Berapa banyak perusahaan/instansi/institusi yang merespons lamaran Anda?",
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
                          value: selectedResponse,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedResponse = newValue;
                            });
                          },
                          items: chooseOptions.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style:
                                    MyFont.poppins(fontSize: 12, color: black),
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
                                "Berapa banyak perusahaan/instansi/institusi yang mengundang anda untuk wawancara?",
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
                          value: selectedInvite,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedInvite = newValue;
                            });
                          },
                          items: chooseOptions.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style:
                                    MyFont.poppins(fontSize: 12, color: black),
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
                                "Apakah Anda aktif mencari pekerjaan dalam 4 minggu terakhir? Pilihlah satu jawaban",
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
                          isExpanded: true,
                          value: selectedActive,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedActive = newValue;
                            });
                          },
                          items: chooseOptions2.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Column(
                                children: [
                                  Text(
                                    v,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: MyFont.poppins(
                                        fontSize: 12, color: black),
                                  ),
                                ],
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
                child: CustomTextFieldForm(
                    controller: lainnya,
                    label:
                        "Apakah anda aktif mencari pekerjaan dalam 4 minggu terakhir (Selain jawaban diatas), Tuliskan",
                    keyboardType: TextInputType.text,
                    isEnable: true,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          check();
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
        ));
  }

  void check() {
    if (lainnya.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in the required questions");
    } else {
      handleQuisionerJumlah();
    }
  }

  void handleQuisionerJumlah() async {
    try {
      final response = await ApiServices.quisionercompanyApply(
          selectedBefore.toString(),
          selectedResponse.toString(),
          selectedInvite.toString(),
          selectedActive.toString(),
          lainnya.text);
      if (response['code'] == 201) {
        Fluttertoast.showToast(msg: response['message']);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobsuitabilitySection(),
            ));
      } else if (response['message'] ==
          'gagal mengisi kuisioner Gagal mengisi kuisioner , kamu belum mengisi quisioner sebelumnya') {
        Fluttertoast.showToast(
            msg: "Silahkan isi quisioner sebelumnya terlebih dahulu");
      } else if (response['message'] == 'Quisioner level not found') {
        Fluttertoast.showToast(
            msg: "Silahkan isi quisioner identitas terlebih dahulu");
      } else {
        Fluttertoast.showToast(msg: response['message']);
      }
    } catch (e) {
      print(e);
    }
  }
}
