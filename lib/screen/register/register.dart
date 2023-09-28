import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

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
                  controller: email,
                  style: MyFont.poppins(fontSize: 13, color: black),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => email = val as TextEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukan email anda';
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
                    labelText: "Email",
                    labelStyle: MyFont.poppins(fontSize: 13, color: grey),
                  ),
                ),
              ),
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
                  controller: fullname,
                  style: MyFont.poppins(fontSize: 13, color: black),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => fullname = val as TextEditingController,
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
                    labelText: "Fullname",
                    labelStyle: MyFont.poppins(fontSize: 13, color: grey),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: no_telp,
                  style: MyFont.poppins(fontSize: 13, color: black),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => no_telp = val as TextEditingController,
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
                    labelText: "Telepon",
                    labelStyle: MyFont.poppins(fontSize: 13, color: grey),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: alamat,
                  style: MyFont.poppins(fontSize: 13, color: black),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => alamat = val as TextEditingController,
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
                    labelText: "Alamat",
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
              SizedBox(
                height: 50,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: conpass,
                  controller: conpw,
                  style: MyFont.poppins(fontSize: 13, color: black),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => conpw = val as TextEditingController,
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
                      labelText: "Con Kata sandi",
                      labelStyle: MyFont.poppins(fontSize: 13, color: grey),
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
                      // handleRegister();
                    },
                    child: Text('Masuk',
                        style: MyFont.poppins(
                          fontSize: 12,
                          color: white,
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
