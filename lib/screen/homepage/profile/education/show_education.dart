import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:card_loading/card_loading.dart';
import 'package:cdc_mobile/model/educations_model.dart';
import 'package:cdc_mobile/resource/awesome_dialog.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/profile/education/update_education.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyEducations extends StatelessWidget {
  const MyEducations({super.key});

  void handleDeleteEducation(String educationId) async {
    try {
      final response = await ApiServices.deleteEducations(educationId);
      if (response['code'] == 200) {
        Fluttertoast.showToast(msg: response['message']);
      } else {
        Fluttertoast.showToast(msg: response['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EducationsModel>>(
      future: ApiServices.fetchEducation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: CardLoading(
                  height: 125,
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          List<EducationsModel> educationList = snapshot.data!;
          return ListView.builder(
            itemCount: educationList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              EducationsModel educations = educationList[index];
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
                            "${educations.perguruan}",
                            style: MyFont.poppins(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${educations.strata}, ${educations.jurusan}",
                            style: MyFont.poppins(
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${educations.prodi}, ${educations.tahunMasuk}-${educations.tahunLulus}",
                            style: MyFont.poppins(
                                fontSize: 12,
                                color: first,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "No. Ijazah: ${educations.noIjasah != null ? educations.noIjasah! : '-'}",
                            style: MyFont.poppins(
                              fontSize: 12,
                              color: grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateEducation(
                                      educationsModel: educations),
                                ));
                          },
                          child: Icon(
                            Icons.edit,
                            color: primaryColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            GetAwesomeDialog.showCustomDialog(
                              context: context,
                              dialogType: DialogType.WARNING,
                              title: "Perhatian",
                              desc:
                                  "Apakah anda yakin untuk menghapus data pendidikan anda",
                              btnOkPress: () {
                                handleDeleteEducation("${educations.id}");
                              },
                              btnCancelPress: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                          child: Icon(
                            Icons.delete,
                            color: primaryColor,
                          ),
                        )
                      ],
                    )
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
