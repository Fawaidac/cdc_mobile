import 'package:cdc_mobile/model/pendidikan.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateEducation extends StatefulWidget {
  PendidikanModel pendidikanModel;
  UpdateEducation({required this.pendidikanModel, super.key});

  @override
  State<UpdateEducation> createState() => _UpdateEducationState();
}

class _UpdateEducationState extends State<UpdateEducation> {
  var perguruantinggi = TextEditingController();
  var strata = TextEditingController();
  var jurusan = TextEditingController();
  var prodi = TextEditingController();
  var tahunMasuk = TextEditingController();
  var tahunLulus = TextEditingController();
  var noIjazah = TextEditingController();
  String? selectedStrata;

  List<String> strataOptions = ['D3', 'D4', 'S1', 'S2', 'S3'];

  void handleUpdateEducation() async {
    try {
      final response = await ApiServices.updateEducation(
          perguruantinggi.text,
          jurusan.text,
          prodi.text,
          tahunMasuk.text,
          tahunLulus.text,
          noIjazah.text,
          widget.pendidikanModel.id ?? "",
          selectedStrata.toString());
      if (response['code'] == 200) {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    perguruantinggi.text = widget.pendidikanModel.perguruan.toString();
    selectedStrata = widget.pendidikanModel.strata.toString().substring(0, 2);
    jurusan.text = widget.pendidikanModel.jurusan.toString();
    prodi.text = widget.pendidikanModel.prodi.toString();
    tahunMasuk.text = widget.pendidikanModel.tahunMasuk.toString();
    tahunLulus.text = widget.pendidikanModel.tahunLulus.toString();
    noIjazah.text = widget.pendidikanModel.noIjasah.toString();
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
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
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
            CustomTextFieldForm(
                isEnable: true,
                controller: prodi,
                label: "Program Studi",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
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
                    handleUpdateEducation();
                  },
                  child: Text('Perbarui Data',
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
