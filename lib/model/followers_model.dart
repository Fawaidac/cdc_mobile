class Follower {
  String? id;
  String? fullname;
  String? email;
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
  String? twiter;

  Follower(
      {this.id,
      this.fullname,
      this.email,
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
      this.twiter});

  Follower.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    nik = json['nik'];
    noTelp = json['no_telp'];
    foto = json['foto'];
    alamat = json['alamat'];
    about = json['about'];
    gender = json['gender'];
    level = json['level'];
    linkedin = json['linkedin'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    twiter = json['twiter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['nik'] = this.nik;
    data['no_telp'] = this.noTelp;
    data['foto'] = this.foto;
    data['alamat'] = this.alamat;
    data['about'] = this.about;
    data['gender'] = this.gender;
    data['level'] = this.level;
    data['linkedin'] = this.linkedin;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['twiter'] = this.twiter;
    return data;
  }
}

class FollowersModel {
  int? totalFollowers;
  List<Follower>? followers;

  FollowersModel({this.totalFollowers, this.followers});

  FollowersModel.fromJson(Map<String, dynamic> json) {
    totalFollowers = json['total_followers'];
    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        followers!.add(Follower.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_followers'] = this.totalFollowers;
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
