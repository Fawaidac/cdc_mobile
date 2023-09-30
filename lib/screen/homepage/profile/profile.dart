import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/profile/setting.dart';
import 'package:cdc_mobile/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  bool active = true;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  var searh = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 275,
                  pinned: true,
                  backgroundColor: white,
                  automaticallyImplyLeading: false,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    color: white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://th.bing.com/th/id/OIP.VH39b0tEUhcx63P0laPnKgHaFu?w=230&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
                              radius: 40,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Achmad Fawa'id",
                                  style: MyFont.poppins(
                                      fontSize: 16,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Software Engineer",
                                  style: MyFont.poppins(
                                      fontSize: 14, color: black),
                                ),
                                Text(
                                  "Jember, Jawa Timur",
                                  style: MyFont.poppins(
                                      fontSize: 12, color: black),
                                ),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Setting(),
                                      ));
                                },
                                icon: Icon(
                                  Icons.settings_outlined,
                                  color: first,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "I’m a postive person. I love to travel and eat Always available for chat",
                            style: MyFont.poppins(fontSize: 12, color: black),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: first,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              onPressed: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.remove('token');
                                preferences.remove('tokenExpirationTime');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ));
                              },
                              child: Text('Edit Profile',
                                  style: MyFont.poppins(
                                    fontSize: 14,
                                    color: white,
                                  )),
                            )),
                      ],
                    ),
                  )),
                  bottom: TabBar(
                      unselectedLabelColor: grey,
                      labelColor: first,
                      controller: _tabController,
                      labelStyle: MyFont.poppins(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.bold),
                      unselectedLabelStyle: MyFont.poppins(
                          fontSize: 14,
                          color: grey,
                          fontWeight: FontWeight.w500),
                      isScrollable: false,
                      indicatorColor: first,
                      tabs: const [
                        Tab(text: "Post"),
                        Tab(text: "Pendidikan"),
                        Tab(text: "Pekerjaan"),
                      ]),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBarView(controller: _tabController, children: [
                GridView.builder(
                  shrinkWrap: false,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 60,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      height: 125,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: grey.withOpacity(0.4)),
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      height: 125,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: grey.withOpacity(0.4)),
                    );
                  },
                ),
              ]),
            )));
  }
}
