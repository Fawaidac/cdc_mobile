import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "http://192.168.157.87:8000/api";

  static Future<Map<String, dynamic>> login(
      String emailOrNik, String password) async {
    final res = await http.post(Uri.parse('$baseUrl/auth/login'), body: {
      'emailOrNik': emailOrNik,
      'password': password,
    });
    final data = jsonDecode(res.body);
    return data;
  }

  static Future<Map<String, dynamic>> register(String email, String nik,
      String fullname, String password, String no_telp, String alamat) async {
    final res =
        await http.post(Uri.parse('$baseUrl/auth/user/register'), body: {
      'email': email,
      'nik': nik,
      'fullname': fullname,
      'password': password,
      'no_telp': no_telp,
      'alamat': alamat,
    });
    final data = jsonDecode(res.body);
    return data;
  }
}
