import 'package:card_loading/card_loading.dart';
import 'package:cdc_mobile/model/educations_model.dart';
import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/jobs_model.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/screen1/deatil%20user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class UsersAll extends StatefulWidget {
  const UsersAll({super.key});

  @override
  State<UsersAll> createState() => _UsersAllState();
}

class _UsersAllState extends State<UsersAll> {
  late Future<ApiResponse> _usersFuture;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _usersFuture = ApiServices.getAllUsers(currentPage);
  }

  Future<void> _refreshData() async {
    setState(() {
      _usersFuture = ApiServices.getAllUsers(currentPage);
    });
  }

  Future<void> _loadNextPage() async {
    try {
      final ApiResponse response = await ApiServices.getAllUsers(currentPage);

      if (currentPage < response.totalPage) {
        // Increment the current page and fetch the next page of users
        currentPage++;
        setState(() {
          _usersFuture = Future.value(response);
        });
      }
    } catch (e) {
      // Handle any errors
      print('Error: $e');
    }
  }

  Future<void> _loadPreviousPage() async {
    if (currentPage > 1) {
      // Decrement the current page and fetch the previous page of users
      currentPage--;
      setState(() {
        _usersFuture = ApiServices.getAllUsers(currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: white,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: white),
                    child: Text(
                      "Angkatan",
                      style: MyFont.poppins(fontSize: 12, color: primaryColor),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: white),
                    child: Text(
                      "Jurusan",
                      style: MyFont.poppins(fontSize: 12, color: primaryColor),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: white),
                    child: Text(
                      "Program Studi",
                      style: MyFont.poppins(fontSize: 12, color: primaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<ApiResponse>(
                future: _usersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              CardLoading(
                                height: 130,
                                width: 130,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CardLoading(
                                    height: 20,
                                    width: double.infinity,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: CardLoading(
                                      height: 20,
                                      width: 20,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CardLoading(
                                      height: 20,
                                      width: double.infinity,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CardLoading(
                                      height: 20,
                                      width: double.infinity,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: CardLoading(
                                      height: 20,
                                      width: 100,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  )
                                ],
                              ))
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final userDataList = snapshot.data!.userDataList;
                    final totalPage = snapshot.data!.totalPage;
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userDataList.length,
                          itemBuilder: (context, index) {
                            final userData = userDataList[index];

                            // Mendapatkan informasi pengguna
                            final user = userData['user'] as User;
                            final followers =
                                userData['followers'] as List<FollowersModel>;
                            final jobs = userData['jobs'] as List<JobsModel>;
                            final educations =
                                userData['educations'] as List<EducationsModel>;

                            // Menampilkan informasi pengguna
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => DetailUser(user: user,jobsModel: jobs,educationsModel: educations,),));
                              },
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(bottom: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                          color: grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${user.fullname}',
                                          style: MyFont.poppins(
                                              fontSize: 14,
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: user.gender == "male"
                                                      ? primaryColor
                                                      : Colors.pink),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: white),
                                          child: Column(
                                            children: [
                                              user.gender == "male"
                                                  ? Icon(
                                                      Icons.male,
                                                      size: 15,
                                                      color: primaryColor,
                                                    )
                                                  : const Icon(
                                                      Icons.female,
                                                      size: 15,
                                                      color: Colors.pink,
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3,
                                                      horizontal: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.amber,
                                              ),
                                              child: Text(
                                                "Kunjungi",
                                                style: MyFont.poppins(
                                                    fontSize: 12,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _loadPreviousPage();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: primaryColor,
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_left_rounded,
                                  color: white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "$currentPage",
                                style: MyFont.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: black),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _loadNextPage();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: primaryColor,
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return Text('No data available.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
