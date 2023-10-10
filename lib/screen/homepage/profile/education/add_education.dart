import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({super.key});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  var perguruantinggi = TextEditingController();
  var strata = TextEditingController();
  var jurusan = TextEditingController();
  var prodi = TextEditingController();
  var tahunMasuk = TextEditingController();
  var tahunLulus = TextEditingController();
  var noIjazah = TextEditingController();
  String? selectedStrata;
  String? selectedPerguruan;
  String? selectedProdi;

  List<String> strataOptions = ['D3', 'D4', 'S1', 'S2', 'S3'];
  List<String> perguruanOptions = ['Politeknik Negeri Jember', 'Lainnya'];

  void handleAddEducation() async {
    try {
      String selectedPerguruanValue = selectedPerguruan == 'Lainnya'
          ? perguruantinggi.text
          : "Politeknik Negeri Jember";

      String selectedProdiValue = selectedPerguruan == 'Lainnya'
          ? prodi.text
          : selectedProdi.toString();

      final response = await ApiServices.addEducation(
        selectedPerguruanValue,
        jurusan.text,
        selectedProdiValue,
        tahunMasuk.text,
        tahunLulus.text,
        noIjazah.text,
        selectedStrata.toString(),
      );

      if (response['code'] == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        Fluttertoast.showToast(msg: response['message']);
      } else {
        Fluttertoast.showToast(msg: response['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: first,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Tambah Pendidikan",
          style: MyFont.poppins(
              fontSize: 16, color: first, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
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
                          "Pilih Perguruan Tinggi",
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
                      value: selectedPerguruan,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: black,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedPerguruan = newValue;
                        });
                      },
                      items: perguruanOptions.map((perguruan) {
                        return DropdownMenuItem<String>(
                          value: perguruan,
                          child: Text(
                            perguruan,
                            style: MyFont.poppins(fontSize: 12, color: black),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        hintText: "Pilih Perguruan Tinggi",
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
            if (selectedPerguruan == 'Lainnya')
              CustomTextFieldForm(
                  controller: perguruantinggi,
                  label: "Perguruan Tinggi",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            Padding(
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
                          "Strata",
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
                      value: selectedStrata,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: black,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedStrata = newValue;
                        });
                      },
                      items: strataOptions.map((strata) {
                        return DropdownMenuItem<String>(
                          value: strata,
                          child: Text(
                            strata,
                            style: MyFont.poppins(fontSize: 12, color: black),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        hintText: "Pilih Strata",
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
            CustomTextFieldForm(
                isEnable: true,
                controller: jurusan,
                label: "Jurusan / Fakultas",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            if (selectedPerguruan == 'Lainnya')
              CustomTextFieldForm(
                  isEnable: true,
                  controller: prodi,
                  label: "Program Studi",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            if (selectedPerguruan == 'Politeknik Negeri Jember')
              FutureBuilder<List<Map<String, dynamic>>>(
                future: ApiServices.getProdi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ); // Placeholder for loading state
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final List<Map<String, dynamic>>? prodiList = snapshot.data;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Pilih Program Studi",
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
                            value: selectedProdi,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                selectedProdi = newValue;
                              });
                            },
                            items: prodiList!.map((prodi) {
                              return DropdownMenuItem<String>(
                                value: prodi['nama_prodi'],
                                child: Text(
                                  prodi['nama_prodi'],
                                  style: MyFont.poppins(
                                      fontSize: 12, color: Colors.black),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintText: "Pilih Program Studi",
                              isDense: true,
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 13, color: Colors.grey),
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
                              fillColor: const Color(0xFFFCFDFE),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(); // Placeholder for empty state
                  }
                },
              ),
            CustomTextFieldForm(
                isEnable: true,
                controller: tahunMasuk,
                label: "Tahun Masuk",
                keyboardType: TextInputType.number,
                inputFormatters: FilteringTextInputFormatter.digitsOnly),
            CustomTextFieldForm(
                isEnable: true,
                controller: tahunLulus,
                label: "Tahun Lulus",
                keyboardType: TextInputType.number,
                inputFormatters: FilteringTextInputFormatter.digitsOnly),
            CustomTextFieldForm(
                isEnable: true,
                controller: noIjazah,
                label: "No. Ijazah",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: first, borderRadius: BorderRadius.circular(15)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    handleAddEducation();
                  },
                  child: Text('Simpan',
                      style: MyFont.poppins(
                        fontSize: 14,
                        color: white,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
