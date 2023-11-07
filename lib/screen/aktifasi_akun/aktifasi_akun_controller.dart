import 'dart:io';

import 'package:cdc_mobile/screen/aktifasi_akun/aktifasi_akun_services.dart';
import 'package:cdc_mobile/screen/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AktifasiAkunController {
  Future<void> sendAktifasiAkun(
      File pdf,
      String nama,
      String email,
      String nim,
      String telp,
      String tempatlahir,
      String tanggalLahir,
      String alamat,
      String gender,
      String jurusan,
      String prodi,
      String tahunLulus,
      String angkatan,
      BuildContext context) async {
    final response = await AktifasiAkunServices.send(
        pdf: pdf,
        nama: nama,
        email: email,
        nim: nim,
        telp: telp,
        tempatlahir: tempatlahir,
        tanggalLahir: tanggalLahir,
        alamat: alamat,
        gender: gender,
        jurusan: jurusan,
        prodi: prodi,
        tahunLulus: tahunLulus,
        angkatan: angkatan);
    if (response['code'] == 200) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ));
      Fluttertoast.showToast(msg: "Berhasil mengirim pengajuan aktifasi akun");
    } else if (response['message'] ==
        "The ijazah must not be greater than 1024 kilobytes.") {
      Fluttertoast.showToast(
          msg: "Ukuran pdf ijazah tidak boleh melebihi 1024 KB",
          toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(msg: response['message']);
      print(response['message']);
    }
  }

}
