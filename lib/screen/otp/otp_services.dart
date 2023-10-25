import 'dart:convert';

import 'package:cdc_mobile/services/api.services.dart';
import 'package:http/http.dart' as http;

class OtpServices {
  static Future<Map<String, dynamic>> register(
      String email,
      String nik,
      String fullname,
      String password,
      String telp,
      String alamat,
      String nim,
      int kode) async {
    final Map<String, dynamic> body = {
      'email': email,
      'nik': nik,
      'fullname': fullname,
      'password': password,
      'no_telp': telp,
      'alamat': alamat,
      'nim': alamat,
      'kode_prodi': kode,
    };
    final res = await http.post(
        Uri.parse('${ApiServices.baseUrl}/auth/user/register'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        });
    final data = jsonDecode(res.body);
    return data;
  }
}
