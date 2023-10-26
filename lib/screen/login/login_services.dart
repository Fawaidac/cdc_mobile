import 'dart:convert';

import 'package:cdc_mobile/services/api.services.dart';
import 'package:http/http.dart' as http;

class LoginServices {
  static Future<Map<String, dynamic>> login(
      String emailOrNik, String password) async {
    final res =
        await http.post(Uri.parse('${ApiServices.baseUrl}/auth/login'), body: {
      'emailOrNik': emailOrNik,
      'password': password,
    });
    final data = jsonDecode(res.body);
    return data;
  }

  static Future<Map<String, dynamic>> sendFcmToken(String token) async {
    final res = await http
        .put(Uri.parse('${ApiServices.baseUrl}/user/fcmtoken'), body: {
      'token': token,
    });
    final data = jsonDecode(res.body);
    return data;
  }
}
