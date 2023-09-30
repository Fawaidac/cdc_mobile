import 'package:cdc_mobile/model/pendidikan.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/profile/settings/update_education.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class MyEducations extends StatelessWidget {
  const MyEducations({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PendidikanModel>>(
      future: ApiServices.getPendidikan(),
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
          List<PendidikanModel> pendidikanList = snapshot.data!;
          return ListView.builder(
            itemCount: pendidikanList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              PendidikanModel pendidikan = pendidikanList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdateEducation(pendidikanModel: pendidikan),
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
                        "${pendidikan.perguruan}",
                        style: MyFont.poppins(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${pendidikan.strata}, ${pendidikan.jurusan}",
                        style: MyFont.poppins(
                            fontSize: 14,
                            color: black,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${pendidikan.prodi}, ${pendidikan.tahunMasuk}-${pendidikan.tahunLulus}",
                        style: MyFont.poppins(
                            fontSize: 12,
                            color: first,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "No. Ijazah: ${pendidikan.noIjasah != null ? pendidikan.noIjasah! : '-'}",
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
