import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';

class AddJobs extends StatefulWidget {
  const AddJobs({super.key});

  @override
  State<AddJobs> createState() => _AddJobsState();
}

class _AddJobsState extends State<AddJobs> {
  var perusahaan = TextEditingController();
  var jabatan = TextEditingController();
  var gaji = TextEditingController();
  var tahunMasuk = TextEditingController();
  var tahunKeluar = TextEditingController();
  String? selectedJenisPekerjaan;
  bool isChecked = false;

  List<String> jobsOptions = [
    'Purnawaktu',
    'Paruh Waktu',
    'Wiraswata',
    'Pekerja Lepas',
    'Kontrak',
    'Musiman'
  ];

  void handleAddJob() async {
    String? tahunKeluarValue;
    String? isJobsNow;
    String gajiValue = gaji.text.replaceAll('.', '');
    if (isChecked) {
      tahunKeluarValue = tahunKeluar.text;
      isJobsNow = "1";
    } else {
      tahunKeluarValue = tahunKeluar.text;
      isJobsNow = "0";
    }
    try {
      final response = await ApiServices.addJobs(
        perusahaan.text,
        jabatan.text,
        gajiValue,
        selectedJenisPekerjaan.toString(),
        tahunMasuk.text,
        tahunKeluarValue.toString(),
        isJobsNow,
      );
      if (response['code'] == 201) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
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
          "Tambah Pekerjaan",
          style: MyFont.poppins(
              fontSize: 16, color: first, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomTextFieldForm(
                isEnable: true,
                controller: perusahaan,
                label: "Perusahaan",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            CustomTextFieldForm(
                isEnable: true,
                controller: jabatan,
                label: "Jabatan",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            CustomTextFieldForm(
                isEnable: true,
                controller: gaji,
                label: "Gaji",
                keyboardType: TextInputType.number,
                inputFormatters: FilteringTextInputFormatter.digitsOnly),
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
                          "Jenis Pekerjaan",
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
                      value: selectedJenisPekerjaan,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: black,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedJenisPekerjaan = newValue;
                        });
                      },
                      items: jobsOptions.map((strata) {
                        return DropdownMenuItem<String>(
                          value: strata,
                          child: Text(
                            strata,
                            style: MyFont.poppins(fontSize: 12, color: black),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        hintText: "Pilih Jenis Pekerjaan",
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
                controller: tahunMasuk,
                label: "Tahun Masuk",
                keyboardType: TextInputType.number,
                inputFormatters: FilteringTextInputFormatter.digitsOnly),
            CustomTextFieldForm(
                isEnable: true,
                controller: tahunKeluar,
                label: "Tahun Keluar",
                keyboardType: TextInputType.number,
                inputFormatters: FilteringTextInputFormatter.digitsOnly),
            Row(
              children: [
                Checkbox(
                  activeColor: first,
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Text(
                  "Ini adalah pekerjaan saya saat ini",
                  style: MyFont.poppins(fontSize: 12, color: black),
                )
              ],
            ),
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
                    handleAddJob();
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
