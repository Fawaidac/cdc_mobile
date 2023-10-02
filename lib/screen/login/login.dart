import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/screen/login/lupa_sandi.dart';
import 'package:cdc_mobile/screen/register/register.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var nik = TextEditingController();
  var pw = TextEditingController();
  bool showpass = true;

  bool isTokenExpired(String token) {
    try {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      if (decodedToken.containsKey('exp')) {
        int expirationTimestamp =
            decodedToken['exp'] * 1000; // Convert to milliseconds
        DateTime expirationDateTime =
            DateTime.fromMillisecondsSinceEpoch(expirationTimestamp);
        DateTime currentDateTime = DateTime.now();

        return currentDateTime.isAfter(expirationDateTime);
      }
    } catch (e) {
      print('Error decoding token: $e');
    }

    // Return true if unable to decode or expiration check failed
    return true;
  }

  void checkLogin (){
    if
  }

  void handleLogin() async {
    final emailOrNik = nik.text;
    final password = pw.text;
    try {
      final response = await ApiServices.login(emailOrNik, password);
      if (response['code'] == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response['data']['token']);

        DateTime expirationTime = DateTime.now().add(Duration(days: 7));
        prefs.setInt(
            'tokenExpirationTime', expirationTime.millisecondsSinceEpoch);
        print('Token will expire on: ${expirationTime.toLocal()}');
        Fluttertoast.showToast(msg: response['message']);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
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
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selamat Datang",
                style: MyFont.poppins(
                    fontSize: 24, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Masuk ke akun anda",
                style: MyFont.poppins(fontSize: 12, color: black),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomTextField(
                  controller: nik,
                  label: "Masukan Email / NIK",
                  keyboardType: TextInputType.text,
                  isEnable: true,
                  icon: Icons.mail,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
              Padding(
                padding: const EdgeInsets.only(top: 20),
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
                                    color: primaryColor,
                                    size: 20,
                                  )),
                        isDense: true,
                        hintStyle:
                            GoogleFonts.poppins(fontSize: 13, color: grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
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
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LupaSandi(),
                              ));
                        },
                        child: Text(
                          "Lupa Sandi ?",
                          style:
                              MyFont.poppins(fontSize: 12, color: primaryColor),
                        ))
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 15),
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
                      handleLogin();
                    },
                    child: Text('Masuk',
                        style: MyFont.poppins(
                          fontSize: 14,
                          color: white,
                        )),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum memiliki akun ? ",
                    style: MyFont.poppins(fontSize: 12, color: black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ));
                    },
                    child: Text(
                      "Daftar Sekarang ",
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
