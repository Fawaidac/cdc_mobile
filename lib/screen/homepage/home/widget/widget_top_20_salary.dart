import 'package:cdc_mobile/model/salary_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/alumni/detail%20user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class Top20Salary extends StatefulWidget {
  const Top20Salary({super.key});

  @override
  State<Top20Salary> createState() => _Top20SalaryState();
}

class _Top20SalaryState extends State<Top20Salary> {
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
          "Top 20 Gaji ",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<UserProfile>>(
        future: ApiServices.fetchTopSalary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available.'));
          } else {
            // Data berhasil diambil, tampilkan data sesuai kebutuhan

            List<UserProfile>? userProfiles = snapshot.data;
            if (userProfiles!.isEmpty) {
              return Center(child: Text('No data available'));
            }
            // Tampilkan data sesuai tampilan yang Anda inginkan
            return ListView.builder(
              itemCount: userProfiles.length,
              itemBuilder: (context, index) {
                UserProfile userProfile = userProfiles[index];
                final alumniNumber = index + 1;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                            userProfile.fullname,
                            style: MyFont.poppins(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            userProfile.company,
                            style: MyFont.poppins(
                                fontSize: 14,
                                color: grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: 200,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff74BCFF)),
                            child: Column(
                              children: [
                                Text(
                                  "Rp. ${userProfile.highestSalary}",
                                  style: MyFont.poppins(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
