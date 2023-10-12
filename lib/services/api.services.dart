import 'dart:convert';
import 'dart:io';

import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/educations_model.dart';
import 'package:cdc_mobile/model/jobs_model.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const String baseUrl = "http://192.168.0.117:8000/api";
  static const String baseUrlImage = "http://192.168.0.117:8000/users/";
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

  static Future<String?> updateImageProfile(File imagePath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/user/profile/image'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imagePath.path,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        // Check content type
        if (response.headers['content-type']!.contains('application/json')) {
          final jsonResponse = await response.stream.bytesToString();
          final data = json.decode(jsonResponse);

          if (data['status'] == true) {
            return data['data'];
          } else {
            throw Exception(
                'Failed to update profile image: ${data['message']}');
          }
        } else {
          throw Exception('Invalid content type in the response');
        }
      } else {
        throw Exception(
            'Failed to update profile image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating profile image: $e');
      throw e;
    }
  }

  static Future<List<Map<String, dynamic>>> getProdi() async {
    final response = await http.get(Uri.parse('$baseUrl/prodi'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<Map<String, dynamic>> prodiList =
          List<Map<String, dynamic>>.from(jsonResponse['data']);
      return prodiList;
    } else {
      throw Exception('Failed to fetch prodi');
    }
  }

  static Future<void> updateEmailUser(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.put(
        Uri.parse('$baseUrl/user/profile/email'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonResponse['status'] == true) {
          print(jsonResponse['message']);
        } else {
          throw Exception('Failed to update email: ${jsonResponse['message']}');
        }
      } else {
        throw Exception('Failed to update email. ${jsonResponse['message']}');
      }
    } catch (e) {
      print('Error updating email: $e');
      throw e;
    }
  }

  static Future<UserFollowersInfo> fetchUserFollowers(String userId) async {
    final String url = '$baseUrl/user/followers/$userId';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final int totalFollowers = data['data']['total_followers'];
      final User user = User.fromJson(data['data']['user']);
      List<Follower> followers = [];
      if (data['data']['user']['followers'] != null) {
        data['data']['user']['followers'].forEach((followerData) {
          followers.add(Follower.fromJson(followerData));
        });
      }

      return UserFollowersInfo(
          totalFollowers: totalFollowers, user: user, followers: followers);
    } else {
      throw Exception('Failed to fetch followers');
    }
  }

  static Future<UserFollowedInfo> fetchUserFollowed(String userId) async {
    final String url = '$baseUrl/user/followed/$userId';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final int totalFollowers = data['data']['total_followers'];
      final User user = User.fromJson(data['data']['user']);
      List<Follower> followed = [];
      if (data['data']['user']['followed'] != null) {
        data['data']['user']['followed'].forEach((followerData) {
          followed.add(Follower.fromJson(followerData));
        });
      }

      return UserFollowedInfo(
          totalFollowers: totalFollowers, user: user, followed: followed);
    } else {
      throw Exception('Failed to fetch followers');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchUserAll(int page,
      {int? angkatan, String? prodi}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = '$baseUrl/users?page=$page';
    if (angkatan != null) {
      url += '&angkatan=$angkatan';
    }
    if (prodi != null && prodi.isNotEmpty) {
      url += '&prodi=$prodi';
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    print(url);

    if (response.statusCode == 200) {
      // Parse the response JSON
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == true) {
        final Map<String, dynamic> data = jsonResponse['data'];
        final int totalItems = data['total_items'];
        final List<Map<String, dynamic>> userList = [];

        for (int i = 0; i < totalItems; i++) {
          final Map<String, dynamic> userResponse = data[i.toString()]['user'];
          final List<Map<String, dynamic>> educations =
              data[i.toString()]['educations'].cast<Map<String, dynamic>>();
          final List<Map<String, dynamic>> jobs =
              data[i.toString()]['jobs'].cast<Map<String, dynamic>>();
          final List<Map<String, dynamic>> followers =
              data[i.toString()]['followers'].cast<Map<String, dynamic>>();

          userResponse['educations'] = educations;
          userResponse['jobs'] = jobs;
          userResponse['followers'] = followers;

          userList.add(userResponse);
        }

        return userList;
      } else {
        throw Exception('Failed to fetch users');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<UserDetail> fetchDetailUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('$baseUrl/user/detail/$userId'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == true) {
        return UserDetail.fromJson(jsonResponse['data']);
      } else {
        throw Exception(
            'Failed to fetch user details: ${jsonResponse['message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch user details. Status code: ${response.statusCode}');
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

  static Future<FollowedModel> getFollowed() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(Uri.parse('$baseUrl/user/followed'),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final int totalFollowers = jsonResponse['data']['total_followers'];
        List<Follower> followers = [];
        if (jsonResponse['data']['user']['followed'] != null) {
          jsonResponse['data']['user']['followed'].forEach((followerData) {
            followers.add(Follower.fromJson(followerData));
          });
        }
        return FollowedModel(
            totalFollowers: totalFollowers, followers: followers);
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

  static Future<Map<String, dynamic>> deleteEducations(
      String educationsId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response =
        await http.delete(Uri.parse('$baseUrl/user/education'), body: {
      "id_education": educationsId,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(response.body);
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

  static Future<Map<String, dynamic>> quisionerIdentitas(
    int kodeProdi,
    String nim,
    String namaLengkap,
    String noTelp,
    String email,
    int tahunLulus,
    String nik,
    String npwp,
  ) async {
    final Map<String, dynamic> requestBody = {
      "kode_prodi": kodeProdi,
      "nim": nim,
      "nama_lengkap": namaLengkap,
      "no_telp": noTelp,
      "email": email,
      "tahun_lulus": tahunLulus,
      "nik": nik,
      "npwp": npwp,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/user/quisioner/identity'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }
}
