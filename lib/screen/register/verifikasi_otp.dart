import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/login/login_view.dart';
import 'package:cdc_mobile/screen/register/register.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

class VerifikasiOtp extends StatefulWidget {
  var fullname;
  var email;
  var pw;
  var phone;
  var alamat;
  var nik;
  var nim;
  var kode_prodi;
  VerifikasiOtp(
      {required this.fullname,
      required this.email,
      required this.pw,
      required this.alamat,
      required this.phone,
      required this.nik,
      required this.nim,
      required this.kode_prodi,
      super.key});

  @override
  State<VerifikasiOtp> createState() => _VerifikasiOtpState();
}

class _VerifikasiOtpState extends State<VerifikasiOtp> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  verifikasiOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: Register.verify, smsCode: code);
      await auth.signInWithCredential(credential);
      handleRegister();
    } catch (e) {
      Fluttertoast.showToast(msg: "Kode Otp Salah");
    }
  }

  void handleRegister() async {
    try {
      final response = await ApiServices.register(widget.email, widget.nik,
          widget.fullname, widget.pw, "0" + widget.phone, widget.alamat);
      if (response['code'] == 201) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginView(),
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
    print(widget.email);
  }

  var code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Verifikasi Otp",
              style: MyFont.poppins(fontSize: 24, color: black),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
              child: Text(
                "Masukkan 6 digit kode yang dikirim di nomor +62 ${widget.phone}  untuk verifikasi.",
                style: MyFont.poppins(fontSize: 12, color: black),
              ),
            ),
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                code = value;
              },
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 50, 0, 45),
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
                    verifikasiOtp();
                  },
                  child: Text('Verifikasi',
                      style: MyFont.poppins(
                        fontSize: 14,
                        color: white,
                      )),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tidak menerima kode OTP ? ",
                  style: MyFont.poppins(fontSize: 12, color: black),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Kirim Ulang ",
                    style: MyFont.poppins(
                        fontSize: 12,
                        color: first,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Center(
              child: Text(
                "Harap tunggu kode dalam 00:30s",
                style: MyFont.poppins(fontSize: 12, color: grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
