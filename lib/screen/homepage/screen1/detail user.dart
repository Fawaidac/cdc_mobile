import 'package:card_loading/card_loading.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/followers_user/followers_user.dart';
import 'package:cdc_mobile/screen/homepage/screen1/widget_education_detail_user.dart';
import 'package:cdc_mobile/screen/homepage/screen1/widget_jobs_detail_user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailUser extends StatefulWidget {
  String id;

  DetailUser({required this.id, super.key});

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserDetail? userDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    handleUser();
    fetchFollowerCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Profile",
            style: MyFont.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 380,
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
                              onTap: () async {},
                              child: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://th.bing.com/th/id/OIP.VH39b0tEUhcx63P0laPnKgHaFu?w=230&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
                                radius: 40,
                              ),
                            ),
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
                                      visible: userDetail != null,
                                      replacement: CardLoading(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        ' ${userDetail?.user.fullname ?? " "}',
                                        style: MyFont.poppins(
                                          fontSize: 16,
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  Visibility(
                                      visible: userDetail != null,
                                      replacement: CardLoading(
                                        height: 15,
                                        margin: const EdgeInsets.only(top: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        ' ${userDetail?.user.alamat ?? " "}',
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
                                onPressed: () {},
                                icon: Icon(
                                  Icons.info_outline,
                                  color: primaryColor,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                        visible: userDetail != null,
                                        replacement: CardLoading(
                                          height: 15,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          '${userDetail?.user.about ?? ""}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: MyFont.poppins(
                                            fontSize: 12,
                                            color: black,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  handleFollownUnfollow();
                                },
                                child: Container(
                                  width: 100,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: userDetail?.user.isFollow == true
                                        ? Border.all(
                                            width: 1, color: primaryColor)
                                        : null,
                                    color: userDetail?.user.isFollow == true
                                        ? white
                                        : primaryColor,
                                  ),
                                  child: Text(
                                    userDetail?.user.isFollow == true
                                        ? "Dikuti"
                                        : "Ikuti",
                                    textAlign: TextAlign.center,
                                    style: MyFont.poppins(
                                        fontSize: 12,
                                        color: userDetail?.user.isFollow == true
                                            ? primaryColor
                                            : white),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                          builder: (context) => FollowersUser(
                                            id: userDetail?.user.id ?? "",
                                          ),
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
                                          builder: (context) => FollowersUser(
                                            id: userDetail?.user.id ?? "",
                                          ),
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
                        Text(
                          "Kontak",
                          style: MyFont.poppins(
                              fontSize: 14,
                              color: black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                String linkedin =
                                    userDetail?.user.linkedin ?? "";
                                String url =
                                    "http://www.linkedin.com/in/$linkedin";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
                                }
                              },
                              child: Image.asset(
                                "images/linkedin.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                String linkedin =
                                    userDetail?.user.instagram ?? "";
                                String url =
                                    "http://www.linkedin.com/in/$linkedin";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
                                }
                              },
                              child: Image.asset(
                                "images/instagram.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                String linkedin =
                                    userDetail?.user.twitter ?? "";
                                String url =
                                    "http://www.linkedin.com/in/$linkedin";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
                                }
                              },
                              child: Image.asset(
                                "images/x.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                String linkedin =
                                    userDetail?.user.facebook ?? "";
                                String url =
                                    "http://www.linkedin.com/in/$linkedin";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
                                }
                              },
                              child: Image.asset(
                                "images/facebook.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ],
                        )
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
                EducationDetailUser(userId: userDetail?.user.id ?? ""),
                JobsDetailUser(userId: userDetail?.user.id ?? ""),
              ]),
            )));
  }

  void handleUser() {
    ApiServices.fetchDetailUser(widget.id).then((user) {
      setState(() {
        userDetail = user;
      });
    }).catchError((error) {
      print('Failed to fetch user followers: $error');
    });
  }

  void handleFollow() async {
    try {
      final response = await ApiServices.followUser(userDetail?.user.id ?? "");
      if (response['code'] == 201) {
        Fluttertoast.showToast(msg: response['message']);
        setState(() {
          handleUser();
        });
      } else {
        Fluttertoast.showToast(msg: response['message']);
        print("lu udah ngikuti");
      }
    } catch (e) {
      print(e);
    }
  }

  int followerCount = 0;
  int followedCount = 0;

  Future<void> fetchFollowerCount() async {
    try {
      final apiResponse = await ApiServices.fetchUserFollowers(widget.id);
      final apiResponse2 = await ApiServices.fetchUserFollowed(widget.id);
      setState(() {
        followerCount = apiResponse.totalFollowers!;
        followedCount = apiResponse2.totalFollowers!;
      });
    } catch (e) {
      print('Error fetching follower count: $e');
      // Handle errors if needed
    }
  }

  void handleUnfollow() async {
    try {
      final response =
          await ApiServices.unfollowUser(userDetail?.user.id ?? "");
      if (response['code'] == 200) {
        Fluttertoast.showToast(msg: response['message']);
        setState(() {
          handleUser();
        });
      } else {
        Fluttertoast.showToast(msg: response['message']);
        print("gagal");
      }
    } catch (e) {
      print(e);
    }
  }

  void handleFollownUnfollow() async {
    if (userDetail?.user.isFollow == true) {
      handleUnfollow();
    } else {
      handleFollow();
    }
  }
}
