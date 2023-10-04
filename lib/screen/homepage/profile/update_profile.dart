import 'dart:convert';

import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/resource/textfields_with_checkbox.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  User? user;

  var fullname = TextEditingController();
  var ttl = TextEditingController();
  var telp = TextEditingController();
  var jk = TextEditingController();
  var alamat = TextEditingController();
  var nik = TextEditingController();
  var email = TextEditingController();
  var about = TextEditingController();
  var linkedin = TextEditingController();
  var ig = TextEditingController();
  var fb = TextEditingController();
  var x = TextEditingController();

  Future<void> getUser() async {
    final auth = await ApiServices.userInfo();
    if (auth != null) {
      setState(() {
        user = auth;
        fullname.text = user?.fullname ?? "";
        jk.text = user?.gender ?? "";
        telp.text = user?.noTelp ?? "";
        ttl.text = user?.tempatTanggalLahir ?? "";
        email.text = user?.email ?? "";
        nik.text = user?.nik ?? "";
        alamat.text = user?.alamat ?? "";
        about.text = user?.about ?? "";
        linkedin.text = user?.linkedin ?? "";
        ig.text = user?.instagram ?? "";
        fb.text = user?.facebook ?? "";
        x.text = user?.twitter ?? "";
        isCheckedTelp = user?.noTelp != null && user?.noTelp != "***";
        isCheckedTtl = user?.tempatTanggalLahir != null &&
            user?.tempatTanggalLahir != "***";
        isCheckedEmail = user?.email != null && user?.email != "***";
        isCheckedAlamat = user?.alamat != null && user?.alamat != "***";
        isCheckedNik = user?.nik != null && user?.nik != "***";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  bool? isCheckedTelp;
  bool? isCheckedTtl;
  bool? isCheckedAlamat;
  bool? isCheckedNik;
  bool? isCheckedEmail;

  Future<void> updateVisibility(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestData = {
      "type": [
        {"key": key}
      ],
      "value": value ? 1 : 0
    };

    try {
      final response = await http.put(
        Uri.parse("${ApiServices.baseUrl}/user/visibility/update"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Response: $jsonResponse');
        setState(() {
          getUser();
        });
      } else {
        final data = jsonDecode(response.body);
        print('Error: ${response.statusCode}');
        print('${data['message']} ${data['code']}');
      }
    } catch (e) {
      print('Error: $e');
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
          "Edit Profile",
          style: MyFont.poppins(
              fontSize: 16, color: first, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: softgrey.withOpacity(0.5),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        // left: -10,
                        child: Container(
                            padding: const EdgeInsets.all(6),
                            // color: first,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: first),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 15,
                              color: white,
                            )))
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (user != null)
                      Text(
                        user?.fullname.toString() ?? "",
                        style: MyFont.poppins(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (user != null)
                      Text(
                        user?.alamat.toString() ?? "",
                        style: MyFont.poppins(
                          fontSize: 12,
                          color: black,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                _showModalSheet(
                    context, fullname, "Nama Lengkap", Icons.person);
              },
              child: CustomTextFieldForm(
                  controller: fullname,
                  label: "Nama Lengkap",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            GestureDetector(
              onTap: () {
                _showModalSheet(context, jk, "Jenis Kelamin", Icons.person);
              },
              child: CustomTextFieldForm(
                  controller: jk,
                  label: "Jenis Kelamin",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: second.withOpacity(0.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Visibilitas",
                    style: MyFont.poppins(
                        fontSize: 14,
                        color: first,
                        fontWeight: FontWeight.bold),
                  ),
                  CustomTextFieldCheckbox(
                    controller: telp,
                    label: "No. Telepon",
                    isEnable: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: FilteringTextInputFormatter.digitsOnly,
                    checkboxValue: isCheckedTelp ?? false,
                    onCheckboxChanged: (value) {
                      setState(() {
                        isCheckedTelp = value!;
                        updateVisibility('no_telp', value);
                      });
                    },
                  ),
                  CustomTextFieldCheckbox(
                    controller: ttl,
                    label: "Tempat, Tanggal Lahir",
                    isEnable: true,
                    keyboardType: TextInputType.text,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter,
                    checkboxValue: isCheckedTtl ?? false,
                    onCheckboxChanged: (value) {
                      setState(() {
                        isCheckedTtl = value!;
                        updateVisibility('ttl', value);
                      });
                    },
                  ),
                  CustomTextFieldCheckbox(
                    controller: email,
                    label: "Email",
                    isEnable: true,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter,
                    checkboxValue: isCheckedEmail ?? false,
                    onCheckboxChanged: (value) {
                      setState(() {
                        isCheckedEmail = value!;
                        updateVisibility('email', value);
                      });
                    },
                  ),
                  CustomTextFieldCheckbox(
                    controller: nik,
                    label: "NIK",
                    isEnable: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: FilteringTextInputFormatter.digitsOnly,
                    checkboxValue: isCheckedNik ?? false,
                    onCheckboxChanged: (value) {
                      setState(() {
                        isCheckedNik = value!;
                        updateVisibility('nik', value);
                      });
                    },
                  ),
                  CustomTextFieldCheckbox(
                    controller: alamat,
                    label: "Alamat",
                    isEnable: true,
                    keyboardType: TextInputType.text,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter,
                    checkboxValue: isCheckedAlamat ?? false,
                    onCheckboxChanged: (value) {
                      setState(() {
                        isCheckedAlamat = value!;
                        updateVisibility('alamat', value);
                      });
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _showModalSheet(context, about, "Tentang", Icons.person);
              },
              child: CustomTextFieldForm(
                  controller: about,
                  label: "Tentang",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            GestureDetector(
              onTap: () {
                _showModalSheet(context, linkedin, "LinkedIn", Icons.person);
              },
              child: CustomTextFieldForm(
                  controller: linkedin,
                  label: "LinkedIn",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            GestureDetector(
              onTap: () {
                _showModalSheet(context, ig, "Instagram", Icons.person);
              },
              child: CustomTextFieldForm(
                  controller: ig,
                  label: "Instagram",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            GestureDetector(
              onTap: () {
                _showModalSheet(context, fb, "Facebook", Icons.person);
              },
              child: CustomTextFieldForm(
                  controller: fb,
                  label: "Facebook",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            GestureDetector(
              onTap: () {
                _showModalSheet(context, x, "Twitter", Icons.person);
              },
              child: CustomTextFieldForm(
                  controller: x,
                  label: "Twitter",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
          ],
        ),
      ),
    );
  }

  // var fullname = TextEditingController();
  Padding getTextField(BuildContext context, String name, String label, int i) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 2),
            child: Text(
              label,
              style: MyFont.poppins(fontSize: 12, color: black),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (i == 0) {
                setState(() {
                  fullname.text = label;
                });
                _showModalSheet(context, fullname, label, Icons.person);
              }
            },
            child: Container(
              height: 48,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: black, width: 1),
                  color: white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: MyFont.poppins(fontSize: 12, color: black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container getTextFieldCheckBox(String name, String label, bool checkboxValue,
      ValueChanged<bool?> onCheckboxChanged) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 2),
            child: Text(
              label,
              style: MyFont.poppins(fontSize: 12, color: black),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  // width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: black, width: 1),
                      color: white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: MyFont.poppins(fontSize: 12, color: black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
              Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                value: checkboxValue,
                onChanged: onCheckboxChanged,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1, // Ketebalan border
                    color: black, // Warna border
                  ),
                  borderRadius:
                      BorderRadius.circular(10.0), // Jika ingin sudut terbulat
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showModalSheet(BuildContext context, TextEditingController controller,
      String label, IconData icon) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Wrap(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Masukan $label baru anda :",
                  style: MyFont.poppins(
                      fontSize: 12,
                      color: black,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  textInputAction: TextInputAction.done,
                  controller: controller,
                  style: MyFont.poppins(
                    fontSize: 14,
                    color: black,
                  ),
                  keyboardType: TextInputType.text,
                  readOnly: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13)
                  ],
                  decoration: InputDecoration(
                    hintText: label,
                    isDense: false,
                    prefixIcon: Icon(
                      icon,
                      size: 20,
                      color: softgrey,
                    ),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Batal",
                              style: MyFont.poppins(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                        TextButton(
                            onPressed: () async {
                              handleUpdateProfile();
                            },
                            child: Text(
                              "Simpan",
                              style: MyFont.poppins(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  void handleUpdateProfile() async {
    try {
      final response = await ApiServices.updateUsers(
          fullname.text,
          ttl.text,
          about.text,
          linkedin.text,
          ig.text,
          x.text,
          fb.text,
          telp.text,
          jk.text,
          alamat.text,
          nik.text);
      if (response['code'] == 200) {
        Navigator.pop(context);
        setState(() {
          getUser();
        });
        Fluttertoast.showToast(msg: response['message']);
      } else {
        Fluttertoast.showToast(msg: response['message']);
      }
    } catch (e) {
      print(e);
    }
  }
}
