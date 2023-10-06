import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class JobsDetailUser extends StatelessWidget {
  String userId;
  JobsDetailUser({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetail>(
      future: ApiServices.fetchDetailUser(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No education details available.'));
        } else {
          final job = snapshot.data!.jobs;

          return ListView.builder(
            itemCount: job?.length ?? 0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final data = job![index];
              return Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                height: 125,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff242760).withOpacity(0.03)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data.jabatan}",
                            style: MyFont.poppins(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${data.perusahaan}, ${data.jenisPekerjaan}",
                            style: MyFont.poppins(
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${data.tahunMasuk} - ${data.tahunKeluar != null ? data.tahunKeluar! : 'Sekarang'}",
                            style: MyFont.poppins(
                                fontSize: 12,
                                color: first,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "Rp. ${data.gaji}",
                            style: MyFont.poppins(
                              fontSize: 12,
                              color: grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
