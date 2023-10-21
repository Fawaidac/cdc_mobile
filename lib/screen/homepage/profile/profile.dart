import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:card_loading/card_loading.dart';
import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/awesome_dialog.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/screen/homepage/profile/followers.dart';
import 'package:cdc_mobile/screen/homepage/profile/jobs/show_jobs.dart';
import 'package:cdc_mobile/screen/homepage/profile/setting.dart';
import 'package:cdc_mobile/screen/homepage/profile/education/show_education.dart';
import 'package:cdc_mobile/screen/homepage/profile/update_profile.dart';
import 'package:cdc_mobile/screen/login/login.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  bool active = true;
  late TabController _tabController;
  User? user;

  Future<void> getUser() async {
    final auth = await ApiServices.userInfo();
    if (auth != null) {
      setState(() {
        user = auth;
        print("ok");
      });
    }
  }

  int followerCount = 0;
  int followedCount = 0;

  Future<void> fetchFollowerCount() async {
    try {
      final apiResponse = await ApiServices.getFollowers();
      
      setState(() {
        followerCount = apiResponse.totalFollowers;
      });
    } catch (e) {
      print('Error fetching follower count: $e');
      // Handle errors if needed
    }
  }

  Future<void> fetchFollowedCount() async {
    try {
      final apiResponse = await ApiServices.getFollowed();
      setState(() {
        followedCount = apiResponse.totalFollowers;
      });
    } catch (e) {
      print('Error fetching follower count: $e');
      // Handle errors if needed
    }
  }

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    getUser();
    fetchFollowerCount();
    fetchFollowedCount();
    super.initState();
  }

  var searh = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Profile",
              style: MyFont.poppins(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: white,
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 370,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
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
                                        builder: (context) => Login(),
                                      ));
                                },
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(user?.foto ==
                                          "http://192.168.0.117:8000/users/"
                                      ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                      : user?.foto ?? ""),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Visibility(
                                      visible: user != null,
                                      replacement: CardLoading(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        user?.fullname.toString() ?? "",
                                        style: MyFont.poppins(
                                          fontSize: 16,
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  Visibility(
                                      visible: user != null,
                                      replacement: CardLoading(
                                        height: 15,
                                        margin: const EdgeInsets.only(top: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        user?.alamat.toString() ?? "",
                                        style: MyFont.poppins(
                                          fontSize: 12,
                                          color: black,
                                        ),
                                      )),
                                ],
                              ),
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
                                  color: primaryColor,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Visibility(
                              visible: user != null,
                              replacement: CardLoading(
                                height: 15,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                user?.about.toString() ?? "",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: MyFont.poppins(
                                  fontSize: 12,
                                  color: black,
                                  // fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "80",
                                        style: MyFont.poppins(
                                            fontSize: 20,
                                            color: black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Post",
                                        style: MyFont.poppins(
                                            fontSize: 12,
                                            color: black,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: 1,
                                  height: MediaQuery.of(context).size.height,
                                  color: black.withOpacity(0.2),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Followers(),
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "$followedCount",
                                          style: MyFont.poppins(
                                              fontSize: 20,
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Mengikuti",
                                          style: MyFont.poppins(
                                              fontSize: 12,
                                              color: black,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: 1,
                                  height: MediaQuery.of(context).size.height,
                                  color: black.withOpacity(0.2),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Followers(),
                                        ));
                                  },
                                  child: Container(
                                    color: white,
                                    height: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "$followerCount",
                                          style: MyFont.poppins(
                                              fontSize: 20,
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Pengikut",
                                          style: MyFont.poppins(
                                              fontSize: 12,
                                              color: black,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateProfile(),
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
                      labelColor: primaryColor,
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
                      indicatorColor: primaryColor,
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
                MyEducations(),
                MyJobs(),
              ]),
            )));
  }
}
