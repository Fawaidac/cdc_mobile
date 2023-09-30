class EducationsModel {
  String? perguruan;
  String? jurusan;
  String? strata;
  String? noIjasah;
  String? prodi;
  int? tahunMasuk;
  int? tahunLulus;
  String? id;

  EducationsModel(
      {this.perguruan,
      this.jurusan,
      this.strata,
      this.noIjasah,
      this.prodi,
      this.tahunMasuk,
      this.tahunLulus,
      this.id});

  EducationsModel.fromJson(Map<String, dynamic> json) {
    perguruan = json['perguruan'];
    jurusan = json['jurusan'];
    strata = json['strata'];
    noIjasah = json['no_ijasah'];
    prodi = json['prodi'];
    tahunMasuk = json['tahun_masuk'];
    tahunLulus = json['tahun_lulus'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['perguruan'] = this.perguruan;
    data['jurusan'] = this.jurusan;
    data['strata'] = this.strata;
    data['no_ijasah'] = this.noIjasah;
    data['prodi'] = this.prodi;
    data['tahun_masuk'] = this.tahunMasuk;
    data['tahun_lulus'] = this.tahunLulus;
    data['id'] = this.id;
    return data;
  }
}
