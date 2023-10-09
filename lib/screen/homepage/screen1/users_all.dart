import 'package:card_loading/card_loading.dart';
import 'package:cdc_mobile/model/educations_model.dart';
import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/jobs_model.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/screen1/detail%20user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersAll extends StatefulWidget {
  const UsersAll({super.key});

  @override
  State<UsersAll> createState() => _UsersAllState();
}

class _UsersAllState extends State<UsersAll> {
  Future<List<Map<String, dynamic>>>? _usersFuture;
  List<Map<String, dynamic>>? _users;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadPage(currentPage);
  }

  Future<void> _loadPage(int page) async {
    setState(() {
      _usersFuture = ApiServices.fetchUserAll(page);
      currentPage = page;
    });
    _loadUsers();
  }

  Future<void> _loadNextPage() async {
    await _loadPage(currentPage + 1);
  }

  Future<void> _loadPreviousPage() async {
    if (currentPage > 1) {
      await _loadPage(currentPage - 1);
    }
  }

  bool _isAscending = true;

  void _toggleSortOrder() {
    setState(() {
      _isAscending = !_isAscending;
    });
  }

  var search = TextEditingController();

  Future<void> _loadUsers() async {
    try {
      final users = await _usersFuture;
      if (users != null) {
        // Apply search filter
        if (search.text.isNotEmpty) {
          _users = users.where((user) {
            final fullName = user['fullname'].toLowerCase();
            final searchQuery = search.text.toLowerCase();
            return fullName.contains(searchQuery);
          }).toList();
        } else {
          _users = users;
        }

        setState(() {});
      }
    } catch (e) {
      print('Error loading users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Alumni",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 48,
              child: TextFormField(
                textInputAction: TextInputAction.done,
                controller: search,
                style: MyFont.poppins(fontSize: 12, color: black),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _loadUsers();
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: primaryColor,
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
                InkWell(
                  onTap: _toggleSortOrder,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: primaryColor),
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    child: Text(
                      _isAscending ? "A - Z" : "Z - A",
                      style: MyFont.poppins(fontSize: 12, color: primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
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
                  final users = _users;
                  users!.sort((user1, user2) {
                    final String fullName1 = user1['fullname'];
                    final String fullName2 = user2['fullname'];
                    return _isAscending
                        ? fullName1.compareTo(fullName2)
                        : fullName2.compareTo(fullName1);
                  });
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: users!.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          final List<Map<String, dynamic>> educations =
                              user['educations'].cast<Map<String, dynamic>>();
                          // Filter educations where perguruan is "Politeknik Negeri Jember"
                          final filteredEducations = educations
                              .where((education) =>
                                  education['perguruan'] ==
                                  'Politeknik Negeri Jember')
                              .toList();
                          return InkWell(
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
                                        user['fullname'],
                                        style: MyFont.poppins(
                                            fontSize: 14,
                                            color: black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: user['gender'] == "male"
                                                    ? primaryColor
                                                    : Colors.pink),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: white),
                                        child: Column(
                                          children: [
                                            user['gender'] == "male"
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
                                      for (var education in filteredEducations)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${education['jurusan']}',
                                                style: MyFont.poppins(
                                                    fontSize: 12,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${education['prodi']}',
                                                style: MyFont.poppins(
                                                    fontSize: 12, color: black),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  '${education['tahun_lulus']}',
                                                  textAlign: TextAlign.center,
                                                  style: MyFont.poppins(
                                                      fontSize: 12,
                                                      color: white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
    );
  }
}
