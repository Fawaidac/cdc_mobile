import 'dart:convert';

import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/educations_model.dart';
import 'package:cdc_mobile/model/jobs_model.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const String baseUrl = "http://192.168.0.117:8000/api";
  // static const String baseUrl = "http://192.168.157.87:8000/api";
  // static const String baseUrl = "http://10.10.2.131:8000/api";

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

  // static Future<ApiResponse> getAllUsers(int page) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('token');
  //     final response = await http.get(
  //       Uri.parse('$baseUrl/users?page=$page'),
  //       headers: {"Authorization": "Bearer $token"},
  //     );
  //     final data = jsonDecode(response.body);

  //     if (data['code'] == 200) {
  //       final userDataList = (data['data'] as List).map((userData) {
  //         final user = User.fromJson(userData['user']);
  //         final followers = (userData['followers'] as List)
  //             .map((follower) => FollowersModel.fromJson(follower))
  //             .toList();
  //         final jobs = (userData['jobs'] as List)
  //             .map((job) => JobsModel.fromJson(job))
  //             .toList();
  //         final educations = (userData['educations'] as List)
  //             .map((education) => EducationsModel.fromJson(education))
  //             .toList();

  //         return {
  //           'user': user,
  //           'followers': followers,
  //           'jobs': jobs,
  //           'educations': educations,
  //         };
  //       }).toList();

  //       return ApiResponse(
  //         totalPage: data['total_page'],
  //         totalItems: data['total_items'],
  //         userDataList: userDataList,
  //       );
  //     } else {
  //       // Handle error if response code is not 200
  //       throw Exception('Failed to fetch users. Error: ${data['message']}');
  //     }
  //   } catch (e) {
  //     // Handle any other errors that occur during the API call
  //     throw Exception('Failed to fetch users. Error: $e');
  //   }
  // }
  static Future<ApiResponse> getAllUsers(int page) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
        Uri.parse('$baseUrl/users?page=$page'),
        headers: {"Authorization": "Bearer $token"},
      );
      final data = jsonDecode(response.body);

      if (data['code'] == 200) {
        final totalPage =
            data['total_page'] as int? ?? 1; // Set default to 1 if null
        final totalItems =
            data['total_items'] as int? ?? 0; // Set default to 0 if null

        final userDataList = (data['data'] as List?)?.map((userData) {
              final user =
                  User.fromJson(userData?['user'] as Map<String, dynamic>);
              final followers = (userData?['followers'] as List?)
                      ?.map((follower) => FollowersModel.fromJson(
                          follower as Map<String, dynamic>))
                      .toList() ??
                  [];
              final jobs = (userData?['jobs'] as List?)
                      ?.map((job) =>
                          JobsModel.fromJson(job as Map<String, dynamic>))
                      .toList() ??
                  [];
              final educations = (userData?['educations'] as List?)
                      ?.map((education) => EducationsModel.fromJson(
                          education as Map<String, dynamic>))
                      .toList() ??
                  [];

              return {
                'user': user,
                'followers': followers,
                'jobs': jobs,
                'educations': educations,
              };
            }).toList() ??
            [];

        return ApiResponse(
          totalPage: totalPage,
          totalItems: totalItems,
          userDataList: userDataList,
        );
      } else {
        // Handle error if response code is not 200
        throw Exception('Failed to fetch users. Error: ${data['message']}');
      }
    } catch (e) {
      // Handle any other errors that occur during the API call
      throw Exception('Failed to fetch users. Error: $e');
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

  static Future<Map<String, dynamic>> updateJobs(
    String perusahaan,
    String jabatan,
    String gaji,
    String jenisPekerjaan,
    String tahunMasuk,
    String tahunKeluar,
    String isJobs,
    String jobsId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await http.put(Uri.parse('$baseUrl/user/jobs'), body: {
      'perusahaan': perusahaan,
      'jabatan': jabatan,
      'gaji': gaji,
      'jenis_pekerjaan': jenisPekerjaan,
      'tahun_masuk': tahunMasuk,
      'tahun_keluar': tahunKeluar,
      'is_jobs_now': isJobs,
      'jobs_id': jobsId,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(res.body);
    return data;
  }

  static Future<Map<String, dynamic>> deleteJobs(String jobsId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.delete(Uri.parse('$baseUrl/user/jobs'), body: {
      "jobs_id": jobsId,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> updateUsers(
    String fullname,
    String ttl,
    String about,
    String linkedIn,
    String instagram,
    String x,
    String facebook,
    String no_telp,
    String gender,
    String alamat,
    String nik,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await http.put(Uri.parse('$baseUrl/user/profile'), body: {
      "fullname": fullname,
      "ttl": ttl,
      "about": about,
      "linkedin": linkedIn, // link
      "instagram": instagram, // link
      "x": x, // link
      "facebook": facebook, // link
      "no_telp": no_telp,
      "gender": gender,
      "alamat": alamat,
      "nik": nik,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(res.body);
    return data;
  }

  static Future<Map<String, dynamic>> followUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response =
        await http.post(Uri.parse('$baseUrl/user/followers'), body: {
      "user_id": userId,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> unfollowUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response =
        await http.delete(Uri.parse('$baseUrl/user/followers'), body: {
      "user_id": userId,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(response.body);
    return data;
  }
}
