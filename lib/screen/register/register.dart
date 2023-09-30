import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:cdc_mobile/screen/login/login.dart';
import 'package:cdc_mobile/screen/register/verifikasi_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static String verify = "";
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var email = TextEditingController();
  var alamat = TextEditingController();
  var fullname = TextEditingController();
  var no_telp = TextEditingController();
  var nik = TextEditingController();
  var pw = TextEditingController();
  var conpw = TextEditingController();
  bool showpass = true;
  bool conpass = true;
  var phone = "";

  var countrycode = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+62";
    super.initState();
  }

  registerWithMobileNumber() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: countrycode.text + phone,
        verificationCompleted: (PhoneAuthCredential authCredential) async {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (verificationId, forceResendingToken) {
          Register.verify = verificationId;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifikasiOtp(
                    fullname: fullname.text,
                    email: email.text,
                    pw: pw.text,
                    phone: phone,
                    alamat: alamat.text,
                    nik: nik.text),
              ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Daftar Akun",
                style: MyFont.poppins(
                    fontSize: 24, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Buat akun anda",
                style: MyFont.poppins(fontSize: 12, color: black),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                  controller: fullname,
                  label: "Nama Lengkap",
                  keyboardType: TextInputType.name,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.person_rounded),
              CustomTextField(
                  controller: nik,
                  label: "Nomer Induk Kependudukan",
                  keyboardType: TextInputType.name,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.badge),
              CustomTextField(
                  controller: email,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.mail),
              CustomTextField(
                  controller: alamat,
                  label: "Alamat",
                  keyboardType: TextInputType.emailAddress,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.location_city),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Color(0xffC4C4C4).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 30,
                      child: TextField(
                        controller: countrycode,
                        style: MyFont.poppins(fontSize: 12, color: black),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: MyFont.poppins(fontSize: 20, color: black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      style: MyFont.poppins(fontSize: 13, color: black),
                      onChanged: (value) {
                        phone = value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                          suffixIcon: Icon(
                            Icons.phone_android_rounded,
                            size: 20,
                            color: grey,
                          ),
                          isDense: false,
                          hintStyle: MyFont.poppins(fontSize: 13, color: grey)),
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: pw,
                      obscureText: showpass,
                      style: MyFont.poppins(fontSize: 13, color: black),
                      keyboardType: TextInputType.text,
                      onSaved: (val) => pw = val as TextEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      decoration: InputDecoration(
                        hintText: "Kata Sandi",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showpass = !showpass;
                              });
                            },
                            icon: showpass
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                    color: grey,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: first,
                                    size: 20,
                                  )),
                        isDense: true,
                        hintStyle:
                            GoogleFonts.poppins(fontSize: 13, color: grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Color(0xffC4C4C4).withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: conpw,
                      obscureText: conpass,
                      style: MyFont.poppins(fontSize: 13, color: black),
                      keyboardType: TextInputType.text,
                      onSaved: (val) => conpw = val as TextEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      decoration: InputDecoration(
                        hintText: "Konfirmasi Kata Sandi",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                conpass = !conpass;
                              });
                            },
                            icon: conpass
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                    color: grey,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: first,
                                    size: 20,
                                  )),
                        isDense: true,
                        hintStyle:
                            GoogleFonts.poppins(fontSize: 13, color: grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Color(0xffC4C4C4).withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 15),
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
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () {
                      registerWithMobileNumber();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Lanjut',
                            style: MyFont.poppins(
                              fontSize: 14,
                              color: white,
                            )),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: white,
                        )
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah memiliki akun ? ",
                    style: MyFont.poppins(fontSize: 12, color: black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    child: Text(
                      "Masuk ",
                      style: MyFont.poppins(
                          fontSize: 12,
                          color: first,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
