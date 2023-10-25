import 'package:cdc_mobile/screen/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:cdc_mobile/screen/verifikasi/verifikasi_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cdc_mobile/resource/awesome_dialog.dart';

class VerifikasiController {
  Future<void> handleVerifikasi(String key, BuildContext context) async {
    try {
      final response = await VerifikasiServices.verifikasi(key);
      if (response['code'] == 200) {
        final data = response['data'];

        // Extract the required parameters from the response data
        final String namaLengkap = data['nama_lengkap'];
        final String email = data['email'];
        final String nim = data['nim'];
        final String alamat = data['alamat_domisili'];
        final String prodi = data['program_studi'];

        // Navigate to RegisterView with the extracted parameters
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterView(
              namaLengkap: namaLengkap,
              email: email,
              nim: nim,
              alamat: alamat,
              prodi: prodi,
            ),
          ),
        );
      } else if (response['message'] ==
          "ops , data nim atau email kamu tidak ditemukan silahkan ajukan pengajuan data alumni") {
        // Handle error case
        // ignore: use_build_context_synchronously
        GetAwesomeDialog.showCustomDialog(
          context: context,
          dialogType: DialogType.ERROR,
          title: "Error",
          desc:
              "Nim atau Email anda tidak ditemukan,\nsilahkan ajukan pengajuan data alumni",
          btnOkPress: () {},
          btnCancelPress: () {
            Navigator.pop(context);
          },
        );
        print(response['message']);
      } else {
        // Handle other error cases
        print(response['message']);
      }
    } catch (e) {
      // Handle exceptions
      print(e);
    }
  }
}
