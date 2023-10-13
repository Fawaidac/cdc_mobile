import 'package:cdc_mobile/model/quisioner_check_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/identitas_section.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  QuestionnaireCheck? questionnaireCheck;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuisionerCheck();
  }

  Future<void> fetchQuisionerCheck() async {
    try {
      QuestionnaireCheck fetchedData = await ApiServices.quisionerCheck();
      setState(() {
        questionnaireCheck = fetchedData;
      });
    } catch (e) {
      print('Error fetching quisioner check: $e');
    }
  }

  int calculateCompletedSections() {
    if (questionnaireCheck == null) {
      return 0;
    }
    // Calculate completed sections based on the widget's questionnaireCheck
    return [
      questionnaireCheck!.identitasSection,
      questionnaireCheck!.mainSection,
      questionnaireCheck!.furtheStudySection,
      questionnaireCheck!.competentLevelSection,
      questionnaireCheck!.studyMethodSection,
      questionnaireCheck!.jobsStreetSection,
      questionnaireCheck!.howFindJobsSection,
      questionnaireCheck!.companyAppliedSection,
      questionnaireCheck!.jobSuitabilitySection
    ].where((section) => section == 1).length;
  }

  @override
  Widget build(BuildContext context) {
    int completedSection = calculateCompletedSections();
    int totalSection = 9;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (completedSection != totalSection)
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IdentitasSection(),
                      ));
                },
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          colors: [primaryColor, first],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ayo Isi Kuisioner !",
                            style: MyFont.poppins(
                                fontSize: 18,
                                color: white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Verifikasi akun anda dan bantu rekan alumni untuk mengetahui track record anda",
                            style: MyFont.poppins(fontSize: 12, color: white),
                          ),
                          Image.asset(
                            "images/logowhite.png",
                            height: 40,
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 100,
                        child: SvgPicture.asset(
                          "images/crhd.svg",
                          height: 100,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: LinearProgressIndicator(
                value:
                    totalSection == 0 ? 0.0 : completedSection / totalSection,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lengkapi kuisioner anda agar akun anda terverifikasi",
                  style: MyFont.poppins(fontSize: 12, color: softgrey),
                ),
                Text(
                  '$completedSection/$totalSection',
                  textAlign: TextAlign.end,
                  style: MyFont.poppins(fontSize: 12, color: softgrey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
