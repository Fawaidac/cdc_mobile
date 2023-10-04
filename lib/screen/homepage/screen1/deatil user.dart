import 'package:card_loading/card_loading.dart';
import 'package:cdc_mobile/model/educations_model.dart';
import 'package:cdc_mobile/model/jobs_model.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/profile/education/show_education.dart';
import 'package:cdc_mobile/screen/homepage/profile/jobs/show_jobs.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailUser extends StatefulWidget {
  User user;
  List<JobsModel> jobsModel;
  List<EducationsModel> educationsModel;

  DetailUser(
      {required this.user,
      required this.jobsModel,
      required this.educationsModel,
      super.key});

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFollow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    checkFollowOrNo();
  }

  void checkFollowOrNo() async {
    try {
      final response = await ApiServices.followUser(widget.user.id.toString());
      if (response['message'] == "Ops , kamu sudah mengikuti user tersebut") {
        setState(() {
          isFollow = true;
        });
        // print(isFollow);
      }
    } catch (e) {
      print(e);
    }
  }

  // void checkUnFollow() async {
  //   try {
  //     final response = await ApiServices.followUser(widget.user.id.toString());
  //     if (response['message'] == "Ops , kamu sudah mengikuti user tersebut") {
  //       handleUnfollow();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void handleFollow() async {
    try {
      final response = await ApiServices.followUser(widget.user.id.toString());
      if (response['code'] == 201) {
        Fluttertoast.showToast(msg: response['message']);
        print("berhasil mengikuti");
      } else {
        Fluttertoast.showToast(msg: response['message']);
        print("lu udah ngikuti");
      }
    } catch (e) {
      print(e);
    }
  }

  void handleUnfollow() async {
    try {
      final response =
          await ApiServices.unfollowUser(widget.user.id.toString());
      if (response['code'] == 200) {
        setState(() {
          isFollow = false;
          checkFollowOrNo();
        });
        Fluttertoast.showToast(msg: response['message']);
      } else {
        Fluttertoast.showToast(msg: response['message']);
        print("gagal");
      }
    } catch (e) {
      print(e);
    }
  }

  void handleFollownUnfollow() async {
    if (isFollow == true) {
      handleUnfollow();
    } else if (isFollow == false) {
      handleFollow();
    }
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
                                      visible: widget.user != null,
                                      replacement: CardLoading(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        widget.user.fullname.toString(),
                                        style: MyFont.poppins(
                                          fontSize: 16,
                                          color: black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  Visibility(
                                      visible: widget.user != null,
                                      replacement: CardLoading(
                                        height: 15,
                                        margin: const EdgeInsets.only(top: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        widget.user.alamat.toString(),
                                        style: MyFont.poppins(
                                          fontSize: 12,
                                          color: black,
                                        ),
                                      )),
                                ],
                              ),
                            ),
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
                                        visible: widget.user != null,
                                        replacement: CardLoading(
                                          height: 15,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          widget.user.about.toString(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: MyFont.poppins(
                                            fontSize: 12,
                                            color: black,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: primaryColor,
                                      ),
                                      child: Text(
                                        "Detail Profile",
                                        style: MyFont.poppins(
                                            fontSize: 12,
                                            color: white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    )
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
                                    border: isFollow
                                        ? Border.all(
                                            width: 1, color: primaryColor)
                                        : null,
                                    color: isFollow ? white : primaryColor,
                                  ),
                                  child: Text(
                                    isFollow ? "Dikuti" : "Ikuti",
                                    textAlign: TextAlign.center,
                                    style: MyFont.poppins(
                                        fontSize: 12,
                                        color: isFollow ? primaryColor : white),
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
                                SizedBox(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "900",
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
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: 1,
                                  height: MediaQuery.of(context).size.height,
                                  color: black.withOpacity(0.2),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => Followers(),
                                    //     ));
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
                                          "0",
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
                MyEducations(),
                MyJobs(),
              ]),
            )));
  }
}
