class JobsModel {
  String? id;
  String? userId;
  String? perusahaan;
  String? jabatan;
  int? gaji;
  String? jenisPekerjaan;
  String? tahunMasuk;
  String? tahunKeluar;
  int? pekerjaanSaatini;
  String? createdAt;
  String? updatedAt;

  JobsModel(
      {this.id,
      this.userId,
      this.perusahaan,
      this.jabatan,
      this.gaji,
      this.jenisPekerjaan,
      this.tahunMasuk,
      this.tahunKeluar,
      this.pekerjaanSaatini,
      this.createdAt,
      this.updatedAt});

  JobsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    perusahaan = json['perusahaan'];
    jabatan = json['jabatan'];
    gaji = json['gaji'];
    jenisPekerjaan = json['jenis_pekerjaan'];
    tahunMasuk = json['tahun_masuk'];
    tahunKeluar = json['tahun_keluar'];
    pekerjaanSaatini = json['pekerjaan_saatini'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['perusahaan'] = this.perusahaan;
    data['jabatan'] = this.jabatan;
    data['gaji'] = this.gaji;
    data['jenis_pekerjaan'] = this.jenisPekerjaan;
    data['tahun_masuk'] = this.tahunMasuk;
    data['tahun_keluar'] = this.tahunKeluar;
    data['pekerjaan_saatini'] = this.pekerjaanSaatini;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
