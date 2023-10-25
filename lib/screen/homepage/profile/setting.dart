import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/profile/education/add_education.dart';
import 'package:cdc_mobile/screen/homepage/profile/jobs/add_jobs.dart';
import 'package:cdc_mobile/screen/homepage/profile/tentang.dart';
import 'package:cdc_mobile/screen/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: primaryColor,
            size: 30,
          ),
        ),
        title: Text(
          "Pengaturan",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Akun",
              style: MyFont.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
            ),
            get("Kartu Alumni", Icons.badge_outlined),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEducation(),
                      ));
                },
                child: get("Pendidikan", Icons.school_outlined)),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddJobs(),
                      ));
                },
                child: get("Pekerjaan", Icons.work_outline)),
            get("Ubah Sandi", Icons.lock_outline),
            Text(
              "Aksi",
              style: MyFont.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
            ),
            get("Notifikasi", Icons.notifications_outlined, show: true),
            GestureDetector(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.remove('token');
                  preferences.remove('tokenExpirationTime');
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginView(),
                      ));
                },
                child: get("Keluar", Icons.logout)),
            Text(
              "Info",
              style: MyFont.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Tentang(),
                      ));
                },
                child: get("Tentang", Icons.help_outline))
          ],
        ),
      ),
    );
  }

  Padding get(String name, IconData iconData, {bool show = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        color: white,
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Icon(
              iconData,
              color: primaryColor,
              size: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: MyFont.poppins(fontSize: 14, color: black),
            ),
            Spacer(),
            show
                ? Transform.scale(
                    scale: 0.6,
                    child: Switch(
                      value: true,
                      onChanged: (bool value1) {},
                      activeColor: primaryColor,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
