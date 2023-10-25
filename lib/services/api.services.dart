import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cdc_mobile/model/comment_model.dart';
import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/educations_model.dart';
import 'package:cdc_mobile/model/jobs_model.dart';
import 'package:cdc_mobile/model/quisioner_check_model.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/awesome_dialog.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const String baseUrl = "http://192.168.0.117:8000/api";
  static const String baseUrlImage = "http://192.168.0.117:8000/users/";

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

  static Future<Map<String, dynamic>> post({
    required File image,
    required String linkApply,
    required String company,
    required String description,
    required String expired,
    required String typeJob,
    required String position,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Buat request Multipart
    final request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/user/post'));
    request.headers['Authorization'] = 'Bearer $token';

    // Tambahkan data Multipart
    request.fields['link_apply'] = linkApply;
    request.fields['company'] = company;
    request.fields['description'] = description;
    request.fields['expired'] = expired;
    request.fields['type_job'] = typeJob;
    request.fields['position'] = position;

    // Tambahkan gambar sebagai File Multipart
    final imageFileName = path.basename(image.path);
    final imageStream = http.ByteStream(image.openRead());
    final imageLength = await image.length();
    final imageUpload = http.MultipartFile('image', imageStream, imageLength,
        filename: imageFileName);
    request.files.add(imageUpload);

    final response = await request.send();
    final streamedResponse = await http.Response.fromStream(response);
    final data = json.decode(streamedResponse.body);
    return data;
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

  static Future<List<Map<String, dynamic>>> fetchUserAll(
      int page, BuildContext context,
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
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
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
        print('Failed to fetch users'); // Menampilkan pesan kesalahan ke konsol
      }
    } else if (jsonResponse['message'] ==
        "ops , nampaknya akun kamu belum terverifikasi") {
      // ignore: use_build_context_synchronously
      GetAwesomeDialog.showCustomDialog(
        isTouch: false,
        context: context,
        dialogType: DialogType.ERROR,
        title: "Error",
        desc:
            "ops , nampaknya akun kamu belum terverifikasi, Silahkan isi quisioner terlebih dahulu",
        btnOkPress: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        },
        btnCancelPress: () => Navigator.pop(context),
      );
      print('Account is not verified');
    } else {
      print(
          'Failed to load data ${response.statusCode}'); // Menampilkan pesan kesalahan ke konsol
    }
    // Mengembalikan Future yang selesai dengan nilai kosong
    return Future.value([]);
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
        final data = json.decode(response.body);
        final int totalFollowers = data['data']['total_followers'];
        List<Follower> followers = [];
        if (data['data']['followers'] != null) {
          data['data']['followers'].forEach((followerData) {
            followers.add(Follower.fromJson(followerData));
          });
        }
        return FollowersModel(
            totalFollowers: totalFollowers, followers: followers);
      } else {
        throw Exception('Failed to fetch followers data');
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
        final data = json.decode(response.body);
        final int totalFollowers = data['data']['total_followers'];
        List<Follower> followers = [];
        if (data['data']['user']['followed'] != null) {
          data['data']['user']['followed'].forEach((followerData) {
            followers.add(Follower.fromJson(followerData));
          });
        }
        return FollowedModel(
            totalFollowers: totalFollowers, followed: followers);
      } else {
        throw Exception('Failed to fetch followed data');
      }
    } catch (e) {
      print('Error fetching followed data: $e');
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
    if (data['code'] == 200) {
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

  static Future<Map<String, dynamic>> quisionerCheck() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
          Uri.parse('$baseUrl/user/quisioner/check'),
          headers: {"Authorization": "Bearer $token"});
      final responseJson = jsonDecode(response.body);
      return responseJson;
    } catch (e) {
      print('Error fetching quisioner check: $e');
      throw e;
    }
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

  static Future<Map<String, dynamic>> quisionerMain(
    String statusValue,
    bool is_less_6_months,
    String pre_grad_employment_months,
    String monthly_income,
    String post_grad_months,
    String code_province,
    String code_regency,
    String agency_type,
    String company_name,
    String job_title,
    String work_level,
  ) async {
    final Map<String, dynamic> requestBody = {
      "status": statusValue,
      "is_less_6_months": is_less_6_months,
      "pre_grad_employment_months": pre_grad_employment_months,
      "monthly_income": monthly_income,
      "post_grad_months": post_grad_months,
      "code_province": code_province,
      "code_regency": code_regency,
      "agency_type": agency_type,
      "company_name": company_name,
      "job_title": job_title,
      "work_level": work_level,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/user/quisioner/main'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> quisionerStudy(
      String studyFunding,
      String univName,
      String prodi,
      String studyStart,
      String educationFunding,
      String finansial,
      String studyJob,
      String jobLevel) async {
    final Map<String, dynamic> requestBody = {
      "study_funding_source": studyFunding,
      "univercity_name": univName,
      "study_program": prodi,
      "study_start_date": studyStart,
      "education_funding_source": educationFunding,
      "financial_source": finansial,
      "study_job_relationship": studyJob,
      "job_education_level": jobLevel,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/user/quisioner/furthestudy'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> quisionerKompetensi(
    String etikLulus,
    String etikNow,
    String keahlianLulus,
    String keahlianNow,
    String englishLulus,
    String englishNow,
    String itLulus,
    String itNow,
    String komunikasiLulus,
    String komunikasiNow,
    String teamWorkLulus,
    String teamWorkNow,
    String selfDevLulus,
    String selfDevNow,
  ) async {
    final Map<String, dynamic> requestBody = {
      "etik_lulus": etikLulus,
      "etika_saatini": etikNow,
      "keahlian_lulus": keahlianLulus,
      "keahlian_saatini": keahlianNow,
      "english_lulus": englishLulus,
      "english_saatini": englishNow,
      "teknologi_informasi_lulus": itLulus,
      "teknologi_informasi_saatini": itNow,
      "komunikasi_lulus": komunikasiLulus,
      "komunikasi_saatini": komunikasiNow,
      "kerjasama_lulus": teamWorkLulus,
      "kerjasama_saatini": teamWorkNow,
      "pengembangan_diri_lulus": selfDevLulus,
      "pengembangan_diri_saatini": selfDevNow,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/user/quisioner/competence'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> quisionerMethodStudy(
    String perkuliahan,
    String demonstrasi,
    String partisipasi,
    String magang,
    String praktikum,
    String kerjaLapang,
    String diskusi,
  ) async {
    final Map<String, dynamic> requestBody = {
      "academicStudy": perkuliahan,
      "demonstrasi": demonstrasi,
      "research_participation": partisipasi,
      "intern": magang,
      "practice": praktikum,
      "field_work": kerjaLapang,
      "discucion": diskusi,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/user/quisioner/studymethod'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> quisionerJobsStreet(
    String jobStart,
    String before,
    String after,
  ) async {
    final Map<String, dynamic> requestBody = {
      "job_search_start": jobStart,
      "before_graduation": before,
      "after_graduation": after,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/user/quisioner/jobstreet'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> quisionerFindJobs(
    bool platform,
    bool vacancies,
    bool exchange,
    bool internet,
    bool company,
    bool kemenakertrans,
    bool comercial,
    bool cdc,
    bool alumni,
    bool network,
    bool relation,
    bool self,
    bool intern,
    bool collage,
    bool other,
    String otherJobs,
  ) async {
    final Map<String, dynamic> requestBody = {
      "news_paper": platform,
      "unknown_vacancies": vacancies,
      "exchange": exchange,
      "contacted_company": company,
      "Kemenakertrans": kemenakertrans,
      "commercial_swasta": comercial,
      "cdc": cdc,
      "alumni": alumni,
      "network_college": network,
      "relation": relation,
      "self_employed": self,
      "intern": intern,
      "workplace_during_college": collage,
      "other": other,
      "other_job_source": otherJobs,
      "internet": internet,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/user/quisioner/howtofindjobs'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> quisionercompanyApply(
    String before,
    String responses,
    String invite,
    String active,
    String other,
  ) async {
    final Map<String, dynamic> requestBody = {
      "job_applications_before_first_job": before,
      "job_applications_responses": responses,
      "interview_invitations": invite,
      "job_search_recently_active": active,
      "job_search_recently_active_other": other,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/user/quisioner/companyapplied'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> quisionerJobsuitability(
    String notReleated,
    String notReleated2,
    String notReason,
    String notReason2,
    String otherReason,
    String otherReason2,
    String otherReason3,
    String otherReason4,
    String otherReason5,
    String otherReason6,
    String otherReason7,
    String otherReason8,
    String otherReason9,
    String otherReason10,
  ) async {
    final Map<String, dynamic> requestBody = {
      "job_suitability_not_related": notReleated,
      "job_suitability_not_related_2": notReleated2,
      "job_suitability_reason": notReason,
      "job_suitability_reason_2": notReason2,
      "other_reason": otherReason,
      "other_reason_2": otherReason2,
      "other_reason_3": otherReason3,
      "other_reason_4": otherReason4,
      "other_reason_5": otherReason5,
      "other_reason_6": otherReason6,
      "other_reason_7": otherReason7,
      "other_reason_8": otherReason8,
      "other_reason_9": otherReason9,
      "other_reason_10": otherReason10,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/user/quisioner/jobsuitability'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> updateLocationUser(
      double lat, double long) async {
    final Map<String, dynamic> requestBody = {
      "latitude": lat,
      "longtitude": long,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('$baseUrl/user/position'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<List<Map<String, dynamic>>?> fetchTopAlumni() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = '$baseUrl/user/ranking/followers';

    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == true) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(jsonResponse['data']);

        List<Map<String, dynamic>> userList = [];

        for (var data in dataList) {
          final Map<String, dynamic> userResponse = data;
          List<Map<String, dynamic>> followers =
              data['followers'].cast<Map<String, dynamic>>();
          userResponse['followers'] = followers;
          userList.add(userResponse);
        }

        return userList;
      } else {
        print('Failed to fetch users'); // Menampilkan pesan kesalahan ke konsol
      }
    } else {
      print(
          'Failed to load data ${response.statusCode}'); // Menampilkan pesan kesalahan ke konsol
    }
    // Mengembalikan Future yang selesai dengan nilai null
    return null;
  }

  static Future<Map<String, dynamic>> getData(int page) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user/post?page=$page'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        print(token);
        final Map<String, dynamic> data = jsonResponse['data'];
        final int totalItems = data['total_item'];
        final int totalPage = data['total_page'];
        final List<Map<String, dynamic>> postList = [];

        for (var i = 0; i < totalItems; i++) {
          final Map<String, dynamic> postResponse = data[i.toString()];
          final List<Map<String, dynamic>> commentsData =
              data[i.toString()]['comments'].cast<Map<String, dynamic>>();
          List<CommentModel> comments = commentsData
              .map((commentData) => CommentModel.fromJson(commentData))
              .toList();

          // Tambahkan objek komentar ke dalam postResponse
          postResponse['comments'] = comments;

          final Map<String, dynamic> uploaderData = postResponse['uploader'];
          User uploader = User.fromJson(uploaderData);

          // Tambahkan objek pengunggah ke dalam postResponse
          postResponse['uploader'] = uploader;
          postList.add(postResponse);
        }

        return {'data': postList, 'totalPage': totalPage};
      } else {
        throw Exception("Failed to fetch data ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
      return Future.value({'data': [], 'totalPage': 0});
    }
  }

  static Future<Map<String, dynamic>> getPostUserLogin({int? page}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }
      String url = '$baseUrl/user/post/login';
      if (page != null) {
        url += '&page=$page';
      }
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonResponse['data'];
        final int totalItems = data['pagination']['total_item'];
        final int totalPage = data['pagination']['total_page'];
        final List<Map<String, dynamic>> postList =
            (data['posts'] as List).map((postData) {
          final Map<String, dynamic> postMap = postData as Map<String, dynamic>;
          final List<Map<String, dynamic>> commentsData =
              postMap['comments'].cast<Map<String, dynamic>>();
          List<CommentModel> comments = commentsData
              .map((commentData) => CommentModel.fromJson(commentData))
              .toList();
          postMap['comments'] = comments;
          return postMap;
        }).toList();

        return {
          'data': postList,
          'total_page': totalPage,
          'total_item': totalItems
        };
      } else {
        throw Exception("Failed to fetch data ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
      return Future.value({'data': [], 'total_page': 0, 'total_item': 0});
    }
  }

  static Future<Map<String, dynamic>> nonActiveComment(
      String postId, bool option) async {
    final Map<String, dynamic> requestBody = {"option": option};
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.put(
        Uri.parse('$baseUrl/user/post/update/comment/$postId'),
        body: jsonEncode(requestBody),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
        });
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> deletePostingan(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.delete(
        Uri.parse('$baseUrl/user/post/delete/$postId'),
        headers: {"Authorization": "Bearer $token"});
    final data = jsonDecode(response.body);
    return data;
  }
}
