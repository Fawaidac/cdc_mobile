import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/alumni/alumni.dart';
import 'package:cdc_mobile/screen/homepage/alumni/detail%20user.dart';
import 'package:cdc_mobile/screen/homepage/home/fasilitas/fasilitas.dart';
import 'package:cdc_mobile/screen/homepage/home/home.dart';
import 'package:cdc_mobile/screen/homepage/posting/posting.dart';
import 'package:cdc_mobile/screen/homepage/profile/profile.dart';
import 'package:cdc_mobile/screen/homepage/alumni/users_all.dart';
import 'package:cdc_mobile/screen/homepage/ikapj/ikapj_screen.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  List<Widget> screen = <Widget>[
    Home(),
    const AlumniView(),
    const Posting(),
    const IkapjScreen(),
    const Profile(),
  ];

  List navbutton = [
    {
      "active": Image.asset(
        "images/active_home.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_home.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Home"
    },
    {
      "active": Image.asset(
        "images/active_graph.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_graph.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Gatau"
    },
    {
      "active": Image.asset(
        "images/active_plus.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_plus.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Posting"
    },
    {
      "active": Image.asset(
        "images/fill.png",
        height: 25,
        width: 25,
      ),
      "non_active": Image.asset(
        "images/non.png",
        height: 25,
        width: 25,
        color: primaryColor,
      ),
      "label": "Gatau"
    },
    {
      "active": Image.asset(
        "images/active_profile.png",
        height: 20,
        color: primaryColor,
        width: 20,
      ),
      "non_active": Image.asset(
        "images/non_active_profile.png",
        height: 20,
        color: primaryColor,
        width: 20,
      ),
      "label": "Profile"
    },
  ];
  void onTap(value) {
    setState(() {
      index = value;
    });
  }

  late PermissionStatus _notificationStatus;
  late PermissionStatus _storageStatus;

  Future<void> requestPermissions() async {
    // Request notification permission
    final notificationStatus = await Permission.notification.request();
    setState(() {
      _notificationStatus = notificationStatus;
    });

    // Request external storage permission
    final storageStatus = await Permission.storage.request();
    setState(() {
      _storageStatus = storageStatus;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermissions();
  }

  List<Map<String, dynamic>> searchResult = [];

  bool active = true;
  var searh = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: index == 0
          ? AppBar(
              backgroundColor: white,
              automaticallyImplyLeading: false,
              title: SizedBox(
                height: 48,
                child: TextFormField(
                  onTap: () {
                    setState(() {
                      active = false;
                    });
                  },
                  textInputAction: TextInputAction.done,
                  controller: searh,
                  onChanged: (value) {
                    // Panggil metode searchUser dengan kata kunci (value) dari TextField
                    ApiServices.searchUser(value).then((users) {
                      // Lakukan sesuatu dengan hasil pencarian pengguna di sini
                      // Misalnya, Anda dapat memperbarui state untuk menampilkan hasilnya.
                      setState(() {
                        searchResult = users;
                      });
                    }).catchError((error) {
                      // Tangani kesalahan jika terjadi
                      print("Error searching users: $error");
                    });
                  },
                  style: MyFont.poppins(fontSize: 12, color: black),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          active = true;
                        });
                      },
                      child: Icon(
                        active ? Icons.search : Icons.close,
                        color: primaryColor,
                      ),
                    ),
                    hintText: "Search",
                    isDense: true,
                    hintStyle: GoogleFonts.poppins(fontSize: 13, color: grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        child: Image.asset(
                          "images/bell.png",
                          height: 20,
                          alignment: Alignment.center,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Fasilitas(),
                              ));
                        },
                        child: Icon(
                          Icons.dashboard_customize_rounded,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            )
          : null,
      body: active
          ? screen[index]
          : ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                final user = searchResult[index];

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailUser(
                                id: user['id'],
                              ),
                            ));
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(user['foto']),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user['fullname'],
                                  style: MyFont.poppins(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  user['gender'],
                                  style: MyFont.poppins(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          unselectedLabelStyle: MyFont.poppins(
              fontSize: 12, color: grey, fontWeight: FontWeight.w300),
          selectedLabelStyle: MyFont.poppins(
              fontSize: 12, color: white, fontWeight: FontWeight.w500),
          selectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          selectedItemColor: primaryColor,
          unselectedItemColor: softgrey,
          currentIndex: index,
          onTap: onTap,
          elevation: 0,
          backgroundColor: Colors.white,
          items: List.generate(5, (index) {
            var navBtn = navbutton[index];
            return BottomNavigationBarItem(
                icon: navBtn["non_active"],
                activeIcon: navBtn["active"],
                label: navBtn["label"]);
          })),
    );
  }
}
