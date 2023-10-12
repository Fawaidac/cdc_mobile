import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class IdentitasSection extends StatefulWidget {
  const IdentitasSection({super.key});

  @override
  State<IdentitasSection> createState() => _IdentitasSectionState();
}

class _IdentitasSectionState extends State<IdentitasSection> {
  var kdptimsmh = TextEditingController();
  var kdpstmsmh = TextEditingController();
  var nim = TextEditingController();
  var nama = TextEditingController();
  var telp = TextEditingController();
  var email = TextEditingController();
  var tahunLulus = TextEditingController();
  var nik = TextEditingController();
  var npwp = TextEditingController();
  String? idProdi;

  String? selectedProdi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kdptimsmh.text = "Politeknik Negeri Jember";
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
        title: Text(
          "Data Diri",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
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
              child: CustomTextFieldForm(
                  controller: kdptimsmh,
                  label: "Kode Perguruan Tinggi/kdptimsmh",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: ApiServices.getProdi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 80,
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
                                idProdi = prodiList
                                    .firstWhere((prodi) =>
                                        prodi['nama_prodi'] ==
                                        selectedProdi)['id']
                                    .toString();
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
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: nim,
                  label: "NIM / nimhsmsmh  (Gunakan Huruf Besar)",
                  keyboardType: TextInputType.text,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: nama,
                  label: "Nama Lengkap / nmmhsmsmh",
                  keyboardType: TextInputType.text,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: telp,
                  label: "Nomor Telepon/HP (Whatsapp) / telpomsmh",
                  keyboardType: TextInputType.number,
                  isEnable: true,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: email,
                  label: "Alamat Email / emailmsmh",
                  keyboardType: TextInputType.emailAddress,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: tahunLulus,
                  label: "Tahun Lulus",
                  keyboardType: TextInputType.number,
                  isEnable: true,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: nik,
                  label: "NIK / nik (Nomor Induk Kependudukan/No KTP)",
                  keyboardType: TextInputType.number,
                  isEnable: true,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: npwp,
                  label: "NPWP / npwp (Nomor Pokok Wajib Pajak)",
                  keyboardType: TextInputType.number,
                  isEnable: true,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        handleQuisionerIdentitas();
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

  void handleQuisionerIdentitas() async {
    try {
      int kodeProdi = int.parse(idProdi ?? "");
      if (selectedProdi != null) {
        final response = await ApiServices.quisionerIdentitas(
            kodeProdi,
            nim.text,
            nama.text,
            telp.text,
            email.text,
            int.parse(tahunLulus.text),
            nik.text,
            npwp.text);
        if (response['code'] == 201) {
          // Navigator.pop(context);
          Fluttertoast.showToast(msg: response['message']);
        } else {
          Fluttertoast.showToast(msg: response['message']);
          print(response['message']);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
