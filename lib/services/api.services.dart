import 'dart:convert';

import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/pendidikan.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const String baseUrl = "http://192.168.0.117:8000/api";

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
        throw Exception("Token not found"); // Token tidak tersedia
      }

      final response = await http.get(Uri.parse('$baseUrl/user/'), headers: {
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data']['user'];
        final user = User.fromJson(jsonData);

        // Simpan data pengguna dalam SharedPreferences
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

  // static Future<List<Follower>> getUserFollowers() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('token');

  //     if (token == null) {
  //       throw Exception("Token not found"); // Token tidak tersedia
  //     }

  //     final response = await http.get(Uri.parse('$baseUrl/user/'), headers: {
  //       "Authorization": "Bearer $token",
  //     });

  //     if (response.statusCode == 200) {
  //       final jsonData =
  //           json.decode(response.body)['data']['followers'] as List;
  //       final followers = jsonData
  //           .map((followerJson) => Follower.fromJson(followerJson))
  //           .toList();

  //       return followers;
  //     } else {
  //       throw Exception("Failed to fetch user followers");
  //     }
  //   } catch (e) {
  //     print("Error fetching user followers: $e");
  //     return [];
  //   }
  // }

  // static Future<ApiResponse> userInfoAll() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('token');

  //     if (token == null) {
  //       throw Exception("Token not found");
  //     }

  //     final response = await http.get(Uri.parse('$baseUrl/user/'), headers: {
  //       "Authorization": "Bearer $token",
  //     });

  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body)['data'];
  //       final user = User.fromJson(jsonData['user']);
  //       final followersData = jsonData['followers'] as List;
  //       final followers = followersData
  //           .map((followerJson) => Follower.fromJson(followerJson))
  //           .toList();
  //       final jobsData = jsonData['jobs'] as List;
  //       final jobs = jobsData.map((jobJson) => Job.fromJson(jobJson)).toList();

  //       final educationsData = jsonData['educations'] as List;
  //       final educations = educationsData
  //           .map((educationJson) => Education.fromJson(educationJson))
  //           .toList();

  //       final apiResponse = ApiResponse(
  //           user: user,
  //           followers: followers,
  //           jobs: jobs,
  //           educations: educations);
  //       return apiResponse;
  //     } else {
  //       throw Exception("Failed to fetch user data");
  //     }
  //   } catch (e) {
  //     print("Error fetching user data: $e");
  //     throw e;
  //   }
  // }

  static Future<List<PendidikanModel>> getPendidikan() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(Uri.parse('$baseUrl/user/education'),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((e) => PendidikanModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load education');
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
}
