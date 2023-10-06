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
  bool? isFollow;

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
    this.isFollow,
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
      twitter: json['twiter'],
      accountStatus: json['account_status'],
      isFollow: json['isFollow'],
    );
  }
}

class UserDetail {
  User user;
  List<EducationsModel>? educations;
  List<JobsModel>? jobs;

  UserDetail({
    required this.user,
    this.educations,
    this.jobs,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    // Parse user
    User user = User.fromJson(json['user']);

    // Parse educations
    List<EducationsModel>? educations;
    if (json['educations'] != null) {
      educations = (json['educations'] as List)
          .map((education) => EducationsModel.fromJson(education))
          .toList();
    }

    // Parse jobs
    List<JobsModel>? jobs;
    if (json['jobs'] != null) {
      jobs =
          (json['jobs'] as List).map((job) => JobsModel.fromJson(job)).toList();
    }

    return UserDetail(
      user: user,
      educations: educations,
      jobs: jobs,
    );
  }
}

class UserFollowersInfo {
  int? totalFollowers;
  User? user;
  List<Follower>? followers;

  UserFollowersInfo(
      {required this.totalFollowers,
      required this.user,
      required this.followers});

  UserFollowersInfo.fromJson(Map<String, dynamic> json) {
    totalFollowers = json['total_followers'];
    user = json['user'];
    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        followers!.add(Follower.fromJson(v));
      });
    }
  }
}

class UserFollowedInfo {
  int? totalFollowers;
  User? user;
  List<Follower>? followed;

  UserFollowedInfo(
      {required this.totalFollowers,
      required this.user,
      required this.followed});

  UserFollowedInfo.fromJson(Map<String, dynamic> json) {
    totalFollowers = json['total_followers'];
    user = json['user'];
    if (json['followed'] != null) {
      followed = [];
      json['followed'].forEach((v) {
        followed!.add(Follower.fromJson(v));
      });
    }
  }
}
