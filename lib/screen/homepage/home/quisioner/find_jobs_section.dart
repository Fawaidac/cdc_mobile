import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/company_apply.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class FindJobsSection extends StatefulWidget {
  const FindJobsSection({super.key});

  @override
  State<FindJobsSection> createState() => _FindJobsSectionState();
}

class _FindJobsSectionState extends State<FindJobsSection> {
  String? selectedPlatform;
  String? selectedVacancies;
  String? selectedExcanges;
  String? selectedInternet;
  String? selectedCompany;
  String? selectedKemenakertrans;
  String? selectedAgen;
  String? selectedInformasi;
  String? selectedKantor;
  String? selectedNetwork;
  String? selectedRelasi;
  String? selectedBisnis;
  String? selectedPenempatan;
  String? selectedCollage;
  String? selectedLainnya;

  var lainnya = TextEditingController();
  List<String> chooseOptions = [
    'Ya',
    'Tidak',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lainnya.text = "...";
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
                  builder: (context) => CompanyApply(),
                ));
          },
          child: Text(
            "Kuisioner Mencari Pekerjaan",
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
                "Bagaimana anda mencari pekerjaan tersebut? Jawaban bisa lebih dari satu  Section",
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
                              "Melalui iklan di koran/majalah, brosur ? ",
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
                        value: selectedPlatform,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedPlatform = newValue;
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
                              "Melamar ke perusahaan tanpa mengetahui lowongan yang ada",
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
                        value: selectedVacancies,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedVacancies = newValue;
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
                              "Pergi ke bursa/pameran kerja",
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
                        value: selectedExcanges,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedExcanges = newValue;
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
                              "Mencari lewat internet/iklan online/milis ",
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
                        value: selectedInternet,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedInternet = newValue;
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
                              "Dihubungi oleh perusahaan",
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
                        value: selectedCompany,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCompany = newValue;
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
                              "Menghubungi Kemenakertrans",
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
                        value: selectedKemenakertrans,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedKemenakertrans = newValue;
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
                              "Menghubungi agen tenaga kerja komersial/swasta",
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
                        value: selectedAgen,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedAgen = newValue;
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
                              "Memperoleh informasi dari pusat/kantor pengembangan karir fakultas/universitas",
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
                        value: selectedInformasi,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedInformasi = newValue;
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
                              "Menghubungi kantor kemahasiswaan/hubungan alumni ",
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
                        value: selectedKantor,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedKantor = newValue;
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
                              "Membangun jejaring (network) sejak masih kuliah",
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
                        value: selectedNetwork,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedNetwork = newValue;
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
                              "Melalui relasi (misalnya dosen, orang tua, saudara, teman, Ikatan Alumni dll.)",
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
                        value: selectedRelasi,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedRelasi = newValue;
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
                              "Membangun bisnis sendiri",
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
                        value: selectedBisnis,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedBisnis = newValue;
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
                              "Melalui penempatan kerja atau magang",
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
                        value: selectedPenempatan,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedPenempatan = newValue;
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
                              "Bekerja di tempat yang sama dengan tempat kerja semasa kuliah",
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
                        value: selectedCollage,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCollage = newValue;
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
                              "Mencari lewat internet/iklan online/milis ",
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
                        value: selectedInternet,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedInternet = newValue;
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
                              "Lainnya",
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
                        value: selectedLainnya,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedLainnya = newValue;
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
                      "Mendapatkan pekerjaan selain yang sudah ditanyakan (diatas), Tuliskan",
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
      ),
    );
  }

  void check() {
    if (selectedPlatform == null ||
        selectedVacancies == null ||
        selectedExcanges == null ||
        selectedInternet == null ||
        selectedCompany == null ||
        selectedKemenakertrans == null ||
        selectedAgen == null ||
        selectedInformasi == null ||
        selectedKantor == null ||
        selectedNetwork == null ||
        selectedRelasi == null ||
        selectedBisnis == null ||
        selectedPenempatan == null ||
        selectedCollage == null ||
        selectedLainnya == null) {
      Fluttertoast.showToast(
        msg: "Please fill in the required questions",
      );
    } else {
      handleQuisionerFindJobs();
    }
  }

  void handleQuisionerFindJobs() async {
    bool platformValue = selectedPlatform == 'Ya' ? true : false;
    bool vacanciesValue = selectedVacancies == 'Ya' ? true : false;
    bool exchangeValue = selectedExcanges == 'Ya' ? true : false;
    bool internetValue = selectedInternet == 'Ya' ? true : false;
    bool companyValue = selectedCompany == 'Ya' ? true : false;
    bool kemenakertransValue = selectedKemenakertrans == 'Ya' ? true : false;
    bool comercialValue = selectedAgen == 'Ya' ? true : false;
    bool cdcValue = selectedInformasi == 'Ya' ? true : false;
    bool alumniValue = selectedKantor == 'Ya' ? true : false;
    bool networkValue = selectedNetwork == 'Ya' ? true : false;
    bool relationValue = selectedRelasi == 'Ya' ? true : false;
    bool selfValue = selectedBisnis == 'Ya' ? true : false;
    bool internValue = selectedPenempatan == 'Ya' ? true : false;
    bool collageValue = selectedCollage == 'Ya' ? true : false;
    bool otherValue = selectedLainnya == 'Ya' ? true : false;
    String? otherJobs = lainnya.text == "..." ? null : lainnya.text;
    try {
      final response = await ApiServices.quisionerFindJobs(
          platformValue,
          vacanciesValue,
          exchangeValue,
          internetValue,
          companyValue,
          kemenakertransValue,
          comercialValue,
          cdcValue,
          alumniValue,
          networkValue,
          relationValue,
          selfValue,
          internValue,
          collageValue,
          otherValue,
          otherJobs ?? "");

      if (response['code'] == 201) {
        Fluttertoast.showToast(msg: response['message']);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompanyApply(),
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
