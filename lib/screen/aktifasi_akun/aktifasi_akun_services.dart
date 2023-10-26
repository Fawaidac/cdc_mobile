import 'dart:convert';
import 'dart:io';

import 'package:cdc_mobile/services/api.services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class AktifasiAkunServices {
  static Future<Map<String, dynamic>> send({
    required File pdf,
    required String nama,
    required String email,
    required String nim,
    required String telp,
    required String tempatlahir,
    required String tanggalLahir,
    required String alamat,
    required String gender,
    required String jurusan,
    required String prodi,
    required String tahunLulus,
    required String angkatan,
  }) async {
    // Buat request Multipart
    final request = http.MultipartRequest(
        'POST', Uri.parse('${ApiServices.baseUrl}/alumni/submissions'));

    // Tambahkan data Multipart
    request.fields['nama_lengkap'] = nama;
    request.fields['nim'] = nim;
    request.fields['email'] = email;
    request.fields['no_telp'] = telp;
    request.fields['tempat_lahir'] = tempatlahir;
    request.fields['tanggal_lahir'] = tanggalLahir;
    request.fields['alamat_domisili'] = alamat;
    request.fields['jenis_kelamin'] = gender;
    request.fields['jurusan'] = jurusan;
    request.fields['program_studi'] = prodi;
    request.fields['tahun_lulus'] = tahunLulus;
    request.fields['angkatan'] = angkatan;

    // Tambahkan gambar sebagai File Multipart
    final pdfFileName = path.basename(pdf.path);
    final pdfStream = http.ByteStream(pdf.openRead());
    final pdfLength = await pdf.length();
    final pdfUpload = http.MultipartFile('ijazah', pdfStream, pdfLength,
        filename: pdfFileName);
    request.files.add(pdfUpload);

    final response = await request.send();
    final streamedResponse = await http.Response.fromStream(response);
    final data = json.decode(streamedResponse.body);
    return data;
  }
}
