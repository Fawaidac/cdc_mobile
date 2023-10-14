import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/study_method_section.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class KompetensiSection extends StatefulWidget {
  const KompetensiSection({super.key});

  @override
  State<KompetensiSection> createState() => _KompetensiSectionState();
}

class _KompetensiSectionState extends State<KompetensiSection> {
  String? selectedEtikaLulus;
  String? selectedEtikaNow;
  String? selectedKeahlianLulus;
  String? selectedKeahlianNow;
  String? selectedEnglishLulus;
  String? selectedEnglishNow;
  String? selectedItLulus;
  String? selectedItNow;
  String? selectedKomunikasiLulus;
  String? selectedKomunikasiNow;
  String? selectedTeamWorkLulus;
  String? selectedTeamWorkNow;
  String? selectedSelfDevLulus;
  String? selectedSelfDevNow;
  List<String> tingkatOptions = [
    'Sangat Rendah',
    'Rendah',
    'Netral',
    'Tinggi',
    'Sangat Tinggi',
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
                  builder: (context) => StudyMethodSection(),
                ));
          },
          child: Text(
            "Kuisioner Tingkat Kompetensi",
            style: MyFont.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
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
                "Tingkat KOMPETENSI anda pada SAAT LULUS dan Tingkat KOMPETENSI anda pada SAAT INI",
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
                              "Pada tingkat mana kompetensi ETIKA anda kuasai pada SAAT LULUS?",
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
                        value: selectedEtikaLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedEtikaLulus = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi ETIKA anda kuasai pada SAAT INI?",
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
                        value: selectedEtikaNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedEtikaNow = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KEAHLIAN BERDASARKAN BIDANG ILMU anda kuasai pada SAAT LULUS?",
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
                        value: selectedKeahlianLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedKeahlianLulus = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KEAHLIAN BERDASARKAN BIDANG ILMU anda kuasai pada SAAT INI?",
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
                        value: selectedKeahlianNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedKeahlianNow = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi BAHASA INGGRIS anda kuasai pada SAAT LULUS?",
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
                        value: selectedEnglishLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedEnglishLulus = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi BAHASA INGGRIS anda kuasai pada SAAT INI?",
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
                        value: selectedEnglishNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedEnglishNow = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi TEKNOLOGI INFORMASI anda kuasai pada SAAT LULUS?",
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
                        value: selectedItLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedItLulus = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi TEKNOLOGI INFORMASI anda kuasai pada SAAT INI?",
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
                        value: selectedItNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedItNow = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KOMUNIKASI anda kuasai pada SAAT LULUS?",
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
                        value: selectedKomunikasiLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedKomunikasiLulus = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KOMUNIKASI anda kuasai pada SAAT INI?",
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
                        value: selectedKomunikasiNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedKomunikasiNow = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KERJA SAMA TIM anda kuasai pada SAAT LULUS?",
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
                        value: selectedTeamWorkLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedTeamWorkLulus = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KERJA SAMA TIM anda kuasai pada SAAT INI?",
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
                        value: selectedTeamWorkNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedTeamWorkNow = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi PENGEMBANGAN DIRI anda kuasai pada SAAT LULUS?",
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
                        value: selectedSelfDevLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedSelfDevLulus = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi PENGEMBANGAN DIRI anda kuasai pada SAAT INI?",
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
                        value: selectedSelfDevNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedSelfDevNow = newValue;
                          });
                        },
                        items: tingkatOptions.map((v) {
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
                        handleQuisionerKompetensi();
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

  void handleQuisionerKompetensi() async {
    try {
      final response = await ApiServices.quisionerKompetensi(
          selectedEtikaLulus.toString(),
          selectedEtikaNow.toString(),
          selectedKeahlianLulus.toString(),
          selectedKeahlianNow.toString(),
          selectedEnglishLulus.toString(),
          selectedEnglishNow.toString(),
          selectedItLulus.toString(),
          selectedItNow.toString(),
          selectedKomunikasiLulus.toString(),
          selectedKomunikasiNow.toString(),
          selectedTeamWorkLulus.toString(),
          selectedTeamWorkNow.toString(),
          selectedSelfDevLulus.toString(),
          selectedSelfDevNow.toString());
      if (response['code'] == 201) {
        Fluttertoast.showToast(msg: response['message']);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudyMethodSection(),
            ));
      } else if (response['message'] ==
          'gagal mengisi kuisioner Quisioner level not found') {
        Fluttertoast.showToast(
            msg: "Silahkan isi quisioner identitas terlebih dahulu");
      } else if (response['message'] ==
          'gagal mengisi kuisioner Ops , Nampaknya kamu belum mengisi quisioner sebelumnya') {
        Fluttertoast.showToast(
            msg: "Silahkan isi quisioner sebelumnya terlebih dahulu");
      } else {
        Fluttertoast.showToast(msg: response['message']);
        print(response['message']);
      }
    } catch (e) {
      print(e);
    }
  }

}
