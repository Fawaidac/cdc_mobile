import 'package:cdc_mobile/model/jobs_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/profile/jobs/update_jobs.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class MyJobs extends StatelessWidget {
  const MyJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JobsModel>>(
      future: ApiServices.fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          List<JobsModel> jobsList = snapshot.data!;
          return ListView.builder(
            itemCount: jobsList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              JobsModel jobs = jobsList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateJobs(jobsModel: jobs),
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  height: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff242760).withOpacity(0.03)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${jobs.jabatan}",
                        style: MyFont.poppins(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${jobs.perusahaan}, ${jobs.jenisPekerjaan}",
                        style: MyFont.poppins(
                            fontSize: 14,
                            color: black,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${jobs.tahunMasuk} - ${jobs.tahunKeluar != null ? jobs.tahunKeluar! : 'Sekarang'}",
                        style: MyFont.poppins(
                            fontSize: 12,
                            color: first,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Rp. ${jobs.gaji}",
                        style: MyFont.poppins(
                          fontSize: 12,
                          color: grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
