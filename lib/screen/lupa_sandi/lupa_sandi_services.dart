import 'dart:convert';

import 'package:cdc_mobile/services/api.services.dart';
import 'package:http/http.dart' as http;

class LupaSandiServices {
  static Future<Map<String, dynamic>> recovery(String email) async {
    final res = await http
        .post(Uri.parse('${ApiServices.baseUrl}/auth/recovery'), body: {
      'email': email,
    });
    final data = jsonDecode(res.body);
    return data;
  }
}
