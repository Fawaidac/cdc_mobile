import 'package:cdc_mobile/model/educations_model.dart';
import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/jobs_model.dart';

class User {
  String? id;
  String? fullname;
  String? email;
  String? tempatTanggalLahir;
  String? nik;
  String? noTelp;
  String? foto;
  String? alamat;
  String? about;
  String? gender;
  String? level;
  String? linkedin;
  String? facebook;
  String? instagram;
  String? twitter;
  String? accountStatus;

  User({
    this.id,
    this.fullname,
    this.email,
    this.tempatTanggalLahir,
    this.nik,
    this.noTelp,
    this.foto,
    this.alamat,
    this.about,
    this.gender,
    this.level,
    this.linkedin,
    this.facebook,
    this.instagram,
    this.twitter,
    this.accountStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      tempatTanggalLahir: json['ttl'],
      nik: json['nik'],
      noTelp: json['no_telp'],
      foto: json['foto'],
      alamat: json['alamat'],
      about: json['about'],
      gender: json['gender'],
      level: json['level'],
      linkedin: json['linkedin'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      twitter: json['twitter'],
      accountStatus: json['account_status'],
    );
  }
}

class Follower {
  String id;
  String fullname;
  String email;
  String nik;
  String noTelp;
  String foto;
  String alamat;
  String about;
  String gender;
  String level;
  String linkedin;
  String facebook;
  String instagram;
  String twitter;

  Follower({
    required this.id,
    required this.fullname,
    required this.email,
    required this.nik,
    required this.noTelp,
    required this.foto,
    required this.alamat,
    required this.about,
    required this.gender,
    required this.level,
    required this.linkedin,
    required this.facebook,
    required this.instagram,
    required this.twitter,
  });

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      nik: json['nik'],
      noTelp: json['no_telp'],
      foto: json['foto'],
      alamat: json['alamat'],
      about: json['about'],
      gender: json['gender'],
      level: json['level'],
      linkedin: json['linkedin'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      twitter: json['twitter'],
    );
  }
}

class Job {
  String id;
  String userId;
  String perusahaan;
  String jabatan;
  int gaji;
  String jenisPekerjaan;
  String tahunMasuk;
  String tahunKeluar;
  int pekerjaanSaatIni;
  String? createdAt;
  String? updatedAt;

  Job({
    required this.id,
    required this.userId,
    required this.perusahaan,
    required this.jabatan,
    required this.gaji,
    required this.jenisPekerjaan,
    required this.tahunMasuk,
    required this.tahunKeluar,
    required this.pekerjaanSaatIni,
    this.createdAt,
    this.updatedAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      userId: json['user_id'],
      perusahaan: json['perusahaan'],
      jabatan: json['jabatan'],
      gaji: json['gaji'],
      jenisPekerjaan: json['jenis_pekerjaan'],
      tahunMasuk: json['tahun_masuk'],
      tahunKeluar: json['tahun_keluar'],
      pekerjaanSaatIni: json['pekerjaan_saatini'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Education {
  String id;
  String userId;
  String strata;
  String jurusan;
  String prodi;
  int tahunMasuk;
  int tahunLulus;
  String noIjasah;
  String perguruan;
  String createdAt;
  String updatedAt;

  Education({
    required this.id,
    required this.userId,
    required this.strata,
    required this.jurusan,
    required this.prodi,
    required this.tahunMasuk,
    required this.tahunLulus,
    required this.noIjasah,
    required this.perguruan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'],
      userId: json['user_id'],
      strata: json['strata'],
      jurusan: json['jurusan'],
      prodi: json['prodi'],
      tahunMasuk: json['tahun_masuk'],
      tahunLulus: json['tahun_lulus'],
      noIjasah: json['no_ijasah'],
      perguruan: json['perguruan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class ApiResponse {
  int totalPage;
  int totalItems;
  List<Map<String, dynamic>> userDataList;

  ApiResponse({
    required this.totalPage,
    required this.totalItems,
    required this.userDataList,
  });
}
