import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: nik,
                  style: MyFont.poppins(fontSize: 13, color: black),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => nik = val as TextEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukan nik anda';
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter,
                    LengthLimitingTextInputFormatter(100)
                  ],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: grey)),
                    labelText: "Nik",
                    labelStyle: MyFont.poppins(fontSize: 13, color: grey),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: showpass,
                  controller: pw,
                  style: MyFont.poppins(fontSize: 13, color: black),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => pw = val as TextEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukan password anda';
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter,
                    LengthLimitingTextInputFormatter(100)
                  ],
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: grey)),
                      labelText: "Kata sandi",
                      labelStyle: MyFont.poppins(fontSize: 13, color: grey),
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
                                ))),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () {
                      // handleLogin();
                    },
                    child: Text('Masuk',
                        style: MyFont.poppins(
                          fontSize: 12,
                          color: white,
                        )),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ));
                  },
                  child: Text(
                    "Register",
                    style: MyFont.poppins(fontSize: 14, color: black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
