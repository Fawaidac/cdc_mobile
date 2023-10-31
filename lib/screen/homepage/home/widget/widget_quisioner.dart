import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cdc_mobile/model/quisioner_check_model.dart';
import 'package:cdc_mobile/resource/awesome_dialog.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/identitas_section.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/widget_all_quisioner.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/screen/login/login_view.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WidgetQuisioner extends StatefulWidget {
  const WidgetQuisioner({super.key});

  @override
  State<WidgetQuisioner> createState() => _WidgetQuisionerState();
}

class _WidgetQuisionerState extends State<WidgetQuisioner> {
  QuestionnaireCheck? questionnaireCheck;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuisionerCheck();
  }

  Future<void> fetchQuisionerCheck() async {
    try {
      final fetchedData = await ApiServices.quisionerCheck();
      print('Response data: $fetchedData');
      if (fetchedData['code'] == 200) {
        QuestionnaireCheck check =
            QuestionnaireCheck.fromJson(fetchedData['data']);
        setState(() {
          questionnaireCheck = check;
        });
      } else if (fetchedData['message'] ==
          "your token is not valid , please login again") {
        // ignore: use_build_context_synchronously
        GetAwesomeDialog.showCustomDialog(
          isTouch: false,
          context: context,
          dialogType: DialogType.ERROR,
          title: "Error",
          desc: "Sesi anda telah habis , silahkan login ulang",
          btnOkPress: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginView(),
                ));
          },
          btnCancelPress: () => Navigator.pop(context),
        );
      }
    } catch (e) {
      print('Error fetching quisioner check: $e');
    }
  }

  int calculateCompletedSections() {
    if (questionnaireCheck == null) {
      return 0;
    }
    return questionnaireCheck!.identitasSection +
        questionnaireCheck!.mainSection +
        questionnaireCheck!.furtheStudySection +
        questionnaireCheck!.competentLevelSection +
        questionnaireCheck!.studyMethodSection +
        questionnaireCheck!.jobsStreetSection +
        questionnaireCheck!.howFindJobsSection +
        questionnaireCheck!.companyAppliedSection +
        questionnaireCheck!.jobSuitabilitySection;
  }

  @override
  Widget build(BuildContext context) {
    int completedSection = calculateCompletedSections();
    int totalSection = 9;
    return Column(
      children: [
        if (completedSection != totalSection)
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WidgetAllQuisioner(),
                  ));
            },
            child: Container(
              height: 175,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: LinearProgressIndicator(
            value: totalSection == 0 ? 0.0 : completedSection / totalSection,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
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
        ),
      ],
    );
  }
}
