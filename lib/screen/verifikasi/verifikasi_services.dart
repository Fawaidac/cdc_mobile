import 'dart:convert';

import 'package:cdc_mobile/services/api.services.dart';
import 'package:http/http.dart' as http;

class VerifikasiServices {
  static Future<Map<String, dynamic>> update() async {
    final res = await http.get(
      Uri.parse('${ApiServices.baseUrl}/alumni/update'),
    );
    final data = jsonDecode(res.body);
    return data;
  }

  static Future<Map<String, dynamic>> verifikasi(String key) async {
    final Map<String, dynamic> body = {
      'key': key,
    };
    final res = await http.post(
        Uri.parse('${ApiServices.baseUrl}/verifikasi/alumni'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        });
    final data = jsonDecode(res.body);
    return data;
  }
}
