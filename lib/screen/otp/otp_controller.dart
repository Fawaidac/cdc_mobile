import 'package:cdc_mobile/screen/login/login_view.dart';
import 'package:cdc_mobile/screen/otp/otp_services.dart';
import 'package:cdc_mobile/screen/register/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  verifikasiOtp(
      String code,
      String email,
      String nik,
      String fullname,
      String password,
      String telp,
      String alamat,
      String nim,
      int kode,
      BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: RegisterView.verify, smsCode: code);
      await auth.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      OtpController().handleRegister(
          email, nik, fullname, password, telp, alamat, nim, kode, context);
    } catch (e) {
      Fluttertoast.showToast(msg: "Kode Otp Salah");
    }
  }

  void handleRegister(
      String email,
      String nik,
      String fullname,
      String password,
      String telp,
      String alamat,
      String nim,
      int kode,
      BuildContext context) async {
    try {
      final response = await OtpServices.register(
          email, nik, fullname, "0$password", telp, alamat, nim, kode);
      if (response['code'] == 201) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
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
}
