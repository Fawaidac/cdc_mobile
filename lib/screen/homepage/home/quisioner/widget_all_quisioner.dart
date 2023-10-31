import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/company_apply.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/competence_section.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/find_jobs_section.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/furthestudy_section.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/identitas_section.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/job_street_section.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/jobsuitability_section.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/main_section.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/study_method_section.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class WidgetAllQuisioner extends StatefulWidget {
  const WidgetAllQuisioner({super.key});

  @override
  State<WidgetAllQuisioner> createState() => _WidgetAllQuisionerState();
}

class _WidgetAllQuisionerState extends State<WidgetAllQuisioner> {
  List<Map<String, dynamic>> quisionerData = [];
  @override
  void initState() {
    super.initState();
    // Fetch questionnaire data from the API when the widget initializes
    fetchQuisionerData();
  }

  Future<void> fetchQuisionerData() async {
    try {
      final response = await ApiServices.quisionerCheck();
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        // Extract the questionnaire data from the 'data' map
        final List<String> questionKeys = [
          'identitas_section',
          'main_section',
          'furthe_study_section',
          'competent_level_section',
          'study_method_section',
          'jobs_street_section',
          'how_find_jobs_section',
          'company_applied_section',
          'job_suitability_section',
        ];

        final List<Map<String, dynamic>> questions = questionKeys
            .map((key) => {
                  'title': key,
                  'value': data[key] == 1,
                })
            .toList();

        setState(() {
          quisionerData = questions;
        });
      }
    } catch (e) {
      print('Error fetching questionnaire data: $e');
    }
  }

  List<String> data = [
    'Identitas Diri',
    'Kuisioner Umum',
    'Studi Lanjut',
    'Tingkat Kompetensi',
    'Metode Pembelajaran',
    'Mulai Mencari Pekerjaan',
    'Bagaimana anda mencari pekerjaan tersebut?',
    'Jumlah Perusahaan/instansi/institusi yang sudah anda lamar',
    'Kesesuaian pekerjaan anda saat ini dengan pendidikan anda ',
  ];

  // bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            )),
        centerTitle: true,
        title: Text(
          "Quisioner",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IdentitasSection(),
                      ));
                } else if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainSection(),
                      ));
                } else if (index == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudySection(),
                      ));
                } else if (index == 3) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KompetensiSection(),
                      ));
                } else if (index == 4) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudyMethodSection(),
                      ));
                } else if (index == 5) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobStreetSection(),
                      ));
                } else if (index == 6) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FindJobsSection(),
                      ));
                } else if (index == 7) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompanyApply(),
                      ));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobsuitabilitySection(),
                      ));
                }
              },
              child: Container(
                color: white,
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      item,
                      style: MyFont.poppins(fontSize: 12, color: black),
                    )),
                    Checkbox(
                      value: quisionerData.isNotEmpty
                          ? quisionerData[index]['value']
                          : false,
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
