import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/screen1/detail%20user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class Top20Alumni extends StatefulWidget {
  const Top20Alumni({super.key});

  @override
  State<Top20Alumni> createState() => _Top20AlumniState();
}

class _Top20AlumniState extends State<Top20Alumni> {
  Future<List<Map<String, dynamic>>?>? alumniData;
  @override
  void initState() {
    super.initState();
    alumniData = ApiServices.fetchTopAlumni();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white.withOpacity(0.98),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            )),
        title: Text(
          "Top 20 Alumni Populer",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: alumniData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Menampilkan indikator loading
          } else if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Menampilkan pesan error jika terjadi kesalahan
          } else {
            // Data berhasil diambil, tampilkan data sesuai kebutuhan
            if (snapshot.data != null) {
              final List<Map<String, dynamic>> alumniList = snapshot.data!;
              // Tampilkan data sesuai tampilan yang Anda inginkan
              return ListView.builder(
                itemCount: alumniList.length,
                itemBuilder: (context, index) {
                  final alumni = alumniList[index];
                  final alumniNumber = index + 1;
                  final totalFollowers = alumni['total_followers'];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailUser(id: alumni['id'])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '#$alumniNumber',
                                  style: MyFont.poppins(
                                      fontSize: 14,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alumni['fullname'],
                                style: MyFont.poppins(
                                    fontSize: 14,
                                    color: black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                totalFollowers.toString(),
                                style: MyFont.poppins(
                                    fontSize: 12,
                                    color: softgrey,
                                    fontWeight: FontWeight.normal),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xffFAC301)),
                                child: Column(
                                  children: [
                                    Text(
                                      "Lihat Profile",
                                      style: MyFont.poppins(
                                          fontSize: 12,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text(
                  'Tidak ada data.'); // Tampilkan pesan jika data kosong
            }
          }
        },
      ),
    );
  }
}
