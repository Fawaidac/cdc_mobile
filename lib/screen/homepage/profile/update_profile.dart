import 'dart:convert';
import 'dart:io';

import 'package:cdc_mobile/model/user_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields_form.dart';
import 'package:cdc_mobile/resource/textfields_with_checkbox.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/screen/login/login_view.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
        selectedGender = user?.gender ?? "";
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
        print(user?.twitter);
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

  List<String> genderOptions = [
    'male',
    'female',
  ];
  String? selectedGender;

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

  File? image;

  Future getImageGalerry() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(imageFile!.path);
    });
    if (image != null) {
      await uploadProfileImage();
    } else {
      print("imagenull");
    }
  }

  Future<void> uploadProfileImage() async {
    if (image == null) {
      Fluttertoast.showToast(msg: "Silahkan pilih image");
    }

    try {
      String? imageUrl = await ApiServices.updateImageProfile(image!);
      if (imageUrl != null) {
        // Update the UI or save the image URL wherever needed.
        print('Image URL: $imageUrl');
      } else {
        // Handle null image URL
      }
    } catch (e) {
      // Handle errors
      print('Error updating profile image: $e');
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
                GestureDetector(
                  onTap: () {
                    getImageGalerry();
                  },
                  child: Stack(
                    children: [
                      image == null
                          ? CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(user?.foto == null
                                  ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                  : user?.foto ?? ""),
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundImage: FileImage(image!),
                            ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              padding: const EdgeInsets.all(6),
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
            CustomTextFieldForm(
                controller: fullname,
                isEnable: true,
                label: "Nama Lengkap",
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
                          "Jenis Kelamin",
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
                      value: selectedGender,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: black,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                      },
                      items: genderOptions.map((strata) {
                        return DropdownMenuItem<String>(
                          value: strata,
                          child: Text(
                            strata,
                            style: MyFont.poppins(fontSize: 12, color: black),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        hintText: "Pilih Jenis Kelamin",
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
                    onTap: () => openDialog(),
                    label: "Email",
                    isEnable: true,
                    isReadOnly: true,
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
            CustomTextFieldForm(
                controller: about,
                label: "Tentang",
                isEnable: true,
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            CustomTextFieldForm(
                controller: linkedin,
                isEnable: true,
                label: "LinkedIn",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            CustomTextFieldForm(
                controller: ig,
                isEnable: true,
                label: "Instagram",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            CustomTextFieldForm(
                controller: fb,
                isEnable: true,
                label: "Facebook",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            CustomTextFieldForm(
                controller: x,
                isEnable: true,
                label: "Twitter",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [second, first]),
                    borderRadius: BorderRadius.circular(15)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    handleUpdateProfile();
                  },
                  child: Text('Simpan Perubahan',
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
          selectedGender.toString(),
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

  var newEmail = TextEditingController();
  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white, // Change the background color here
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Change the radius here
          ),
          title: Text(
            "Perbarui email anda",
            style: MyFont.poppins(fontSize: 14, color: primaryColor),
          ),
          content: TextField(
            controller: newEmail,
            autofocus: true,
            style: MyFont.poppins(fontSize: 12, color: black),
            decoration: InputDecoration(
              hintText: "Masukan email baru anda",
              hintStyle: MyFont.poppins(fontSize: 12, color: softgrey),
              isDense: true,
              filled: true,
              fillColor: const Color(0xFFFCFDFE),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffF0F1F7),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () async {
                try {
                  await ApiServices.updateEmailUser(newEmail.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginView(),
                      )); // Navigate to login screen
                  Fluttertoast.showToast(
                    msg: "Email updated successfully. Please log in again.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } catch (e) {
                  Fluttertoast.showToast(msg: e.toString());
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: primaryColor),
                child: Text(
                  "Simpan",
                  style: MyFont.poppins(fontSize: 12, color: white),
                ),
              ),
            )
          ],
        ),
      );
}
