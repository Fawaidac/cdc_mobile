import 'package:cdc_mobile/screen/register/register_services.dart';
import 'package:cdc_mobile/screen/register/register_view.dart';
import 'package:cdc_mobile/screen/register/verifikasi_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> checkEmail(
      String email,
      BuildContext context,
      String countrycode,
      String phone,
      String fullname,
      String pw,
      String alamat,
      String nik,
      String nim,
      String idProdi) async {
    try {
      final response = await RegisterServices.checkEmail(email);
      if (response['code'] == 200) {
        // ignore: use_build_context_synchronously
        RegisterController().registerWithMobileNumber(context, countrycode,
            phone, fullname, email, pw, alamat, nik, nim, idProdi);
      } else {
        Fluttertoast.showToast(msg: response['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> registerWithMobileNumber(
      BuildContext context,
      String countrycode,
      String phone,
      String fullname,
      String email,
      String pw,
      String alamat,
      String nik,
      String nim,
      String idProdi) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: countrycode + phone,
        verificationCompleted: (PhoneAuthCredential authCredential) async {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (verificationId, forceResendingToken) {
          RegisterView.verify = verificationId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifikasiOtp(
                fullname: fullname,
                email: email,
                pw: pw,
                phone: phone,
                alamat: alamat,
                nik: nik,
                nim: nim,
                kode_prodi: idProdi,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
