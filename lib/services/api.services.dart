import 'dart:convert';

import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/educations_model.dart';
import 'package:cdc_mobile/model/jobs_model.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const String baseUrl = "http://192.168.18.32:8000/api";

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

  static Future<User?> userInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await http.get(Uri.parse('$baseUrl/user/'), headers: {
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data']['user'];
        final user = User.fromJson(jsonData);
        prefs.setString('data', json.encode(jsonData));

        return user;
      } else {
        throw Exception("Failed to fetch user data");
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  static Future<FollowersModel> getFollowers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(Uri.parse('$baseUrl/user/followers'),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return FollowersModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to fetch followers');
      }
    } catch (e) {
      print('Error fetching followers: $e');
      throw e;
    }
  }

  static Future<List<EducationsModel>> fetchEducation() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(Uri.parse('$baseUrl/user/education'),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((e) => EducationsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load education');
    }
  }

  static Future<Map<String, dynamic>> addEducation(
      String perguruan,
      String jurusan,
      String prodi,
      String tahunmasuk,
      String tahunlulus,
      String noijazah,
      String strata) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res =
        await http.post(Uri.parse('$baseUrl/user/education/add'), body: {
      'perguruan': perguruan,
      'jurusan': jurusan,
      'prodi': prodi,
      'tahun_masuk': tahunmasuk,
      'tahun_lulus': tahunlulus,
      'no_ijasah': noijazah,
      'strata': strata,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(res.body);
    return data;
  }

  static Future<Map<String, dynamic>> updateEducation(
      String perguruan,
      String jurusan,
      String prodi,
      String tahunmasuk,
      String tahunlulus,
      String noijazah,
      String educationId,
      String strata) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await http
        .put(Uri.parse('$baseUrl/user/education/$educationId'), body: {
      'perguruan': perguruan,
      'jurusan': jurusan,
      'prodi': prodi,
      'tahun_masuk': tahunmasuk,
      'tahun_lulus': tahunlulus,
      'no_ijasah': noijazah,
      'strata': strata,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(res.body);
    return data;
  }

  static Future<List<JobsModel>> fetchJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(Uri.parse('$baseUrl/user/jobs'),
        headers: {"Authorization": "Bearer $token"});
    final data = jsonDecode(response.body);
    if (data['code'] == 202) {
      List jsonResponse = data['data'];
      return jsonResponse.map((e) => JobsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  static Future<Map<String, dynamic>> addJobs(
    String perusahaan,
    String jabatan,
    String gaji,
    String jenisPekerjaan,
    String tahunMasuk,
    String tahunKeluar,
    String isJobs,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await http.post(Uri.parse('$baseUrl/user/jobs'), body: {
      'perusahaan': perusahaan,
      'jabatan': jabatan,
      'gaji': gaji,
      'jenis_pekerjaan': jenisPekerjaan,
      'tahun_masuk': tahunMasuk,
      'tahun_keluar': tahunKeluar,
      'is_jobs_now': isJobs,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(res.body);
    return data;
  }
}
