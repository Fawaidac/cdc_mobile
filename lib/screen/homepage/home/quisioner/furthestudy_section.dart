import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/competence_section.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class StudySection extends StatefulWidget {
  const StudySection({super.key});

  @override
  State<StudySection> createState() => _StudySectionState();
}

class _StudySectionState extends State<StudySection> {
  String? selectedBiaya;
  DateTime? selectedDate;
  String? selectedSumberdana;
  String? selectedHubungan;
  String? selectedTingkat;

  var namaPerguruan = TextEditingController();
  var namaProdi = TextEditingController();
  var sumberDana = TextEditingController();

  List<String> biayaOptions = [
    'Biaya Sendiri',
    'Bea Siswa',
  ];
  List<String> sumberDanaOptions = [
    'Biaya Sendiri/Keluarga',
    'Beasiswa ADIK',
    'Beasiswa BIDIKMISI',
    'Beasiswa PPA',
    'Beasiswa AFIRMASI',
    'Beasiswa Perusahaan/Swasta',
    'Lainnya',
  ];
  List<String> hubunganOptions = [
    'Sangat Erat',
    'Erat',
    'Cukup Erat',
    'Kurang Erat',
    'Tidak sama sekali',
  ];
  List<String> tingkatOptions = [
    'Setingkat lebih tinggi',
    'Tingkat yang sama',
    'Setingkat lebih rendah',
    'Tidak perlu pendidikan tinggi',
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
                  builder: (context) => KompetensiSection(),
                ));
          },
          child: Text(
            "Kuisioner Studi Lanjut",
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
                "Jawablah pertanyaan ini jika Anda melaksanakan STUDI LANJUT (dari D3 ke D4 / dari D4 ke S2)",
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
                          Text(
                            "Sumber biaya Studi Lanjut Anda?",
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
                        value: selectedBiaya,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedBiaya = newValue;
                          });
                        },
                        items: biayaOptions.map((v) {
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
                  controller: namaPerguruan,
                  isEnable: true,
                  label: "Nama Perguruan Tinggi Studi Lanjut",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: namaPerguruan,
                  isEnable: true,
                  label: "Nama Program Studi Studi Lanjut",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Tanggal Masuk Awal Studi Lanjut Anda?",
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
                  ],
                )),
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
                              "Sebutkan sumberdana dalam pembiayaan kuliah? (bukan ketika Studi Lanjut)",
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
                        value: selectedSumberdana,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedSumberdana = newValue;
                          });
                        },
                        items: sumberDanaOptions.map((v) {
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
                    if (selectedSumberdana == 'Lainnya')
                      CustomTextFieldForm(
                          controller: sumberDana,
                          isEnable: true,
                          label: "Sumber dana pembiayaan kuliah",
                          keyboardType: TextInputType.text,
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
                              "Seberapa erat hubungan bidang studi dengan pekerjaan Anda?",
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
                        value: selectedHubungan,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedHubungan = newValue;
                          });
                        },
                        items: hubunganOptions.map((v) {
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
                      child: Text(
                        "Tingkat pendidikan apa yang paling tepat/sesuai untuk pekerjaan anda saat ini?",
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      child: DropdownButtonFormField<String>(
                        value: selectedTingkat,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedTingkat = newValue;
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
                        handleQuisionerStudy();
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

  void handleQuisionerStudy() async {
    String sumberDanaValue = selectedSumberdana == 'Lainnya'
        ? sumberDana.text
        : selectedSumberdana.toString();
    String selectDateValue = "${selectedDate?.toLocal()}".split(' ')[0];

    try {
      final response = await ApiServices.quisionerStudy(
          selectedBiaya.toString(),
          namaPerguruan.text,
          namaProdi.text,
          selectDateValue,
          sumberDanaValue,
          sumberDana.text,
          selectedHubungan.toString(),
          selectedTingkat.toString());
      if (response['code'] == 201) {
        Fluttertoast.showToast(msg: response['message']);
        print("ok");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KompetensiSection(),
            ));
      } else if (response['message'] ==
          'gagal mengisi kuisioner Harap isi quisioner sebelumnya terlebih dahulu') {
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
