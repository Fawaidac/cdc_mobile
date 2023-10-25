import 'package:card_loading/card_loading.dart';
import 'package:cdc_mobile/model/educations_model.dart';
import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/jobs_model.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/alumni/detail%20user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  int? angkatan;
  String? prodi;
  bool _isAscending = true;
  var search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPage(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Daftar Alumni",
            style: MyFont.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    _showAngkatanBottomSheet(context);
                  },
                  child: Container(
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
                ),
                InkWell(
                  onTap: () {
                    _showProdiBottomSheet(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: white),
                    child: Text(
                      "Program Studi",
                      style: MyFont.poppins(fontSize: 12, color: primaryColor),
                    ),
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
                        itemCount: users.length,
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
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    for (var education in filteredEducations)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Jurusan : ${education['jurusan']}',
                                              style: MyFont.poppins(
                                                  fontSize: 12,
                                                  color: black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              'Program studi : ${education['prodi']}',
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
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                '${education['tahun_masuk']}',
                                                textAlign: TextAlign.center,
                                                style: MyFont.poppins(
                                                    fontSize: 12, color: white),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                // alignment: Alignment.bottomRight,
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color(0xffFAC301),
                                                ),
                                                child: Text(
                                                  "Kunjungi",
                                                  style: MyFont.poppins(
                                                      fontSize: 12,
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                  ],
                                ))
                              ],
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

  Future<void> _loadPage(int page) async {
    setState(() {
      _usersFuture = ApiServices.fetchUserAll(page, context,
          angkatan: angkatan, prodi: prodi);
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

  void _toggleSortOrder() {
    setState(() {
      _isAscending = !_isAscending;
    });
  }

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

  void _showProdiBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor),
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: ApiServices.getProdi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading..."); // Or a loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final prodiList = snapshot.data;
                      return ListView.builder(
                        itemCount: prodiList!.length,
                        itemBuilder: (context, index) {
                          // Build your list items here based on the prodiList
                          return ListTile(
                            title: Text(
                              prodiList[index]['nama_prodi'],
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                prodi = prodiList[index]['nama_prodi'];

                                _usersFuture = ApiServices.fetchUserAll(
                                  currentPage,
                                  context,
                                  angkatan: angkatan,
                                  prodi: prodi,
                                );
                              });
                              _loadUsers();
                            },
                          );
                        },
                      );
                    } else {
                      return Text('No prodi data available.');
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  var tahun = TextEditingController();
  void _showAngkatanBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(
              20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
          child: Wrap(
            children: [
              Text(
                "Masukan tahun angkatan :",
                style: MyFont.poppins(
                    fontSize: 12, color: black, fontWeight: FontWeight.normal),
              ),
              TextField(
                controller: tahun,
                style: MyFont.poppins(
                  fontSize: 14,
                  color: black,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4)
                ],
                decoration: InputDecoration(
                  hintText: "No.Telepon",
                  hintStyle: MyFont.poppins(fontSize: 12, color: softgrey),
                  isDense: false,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          int angkatanValue = int.parse(tahun.text);
                          angkatan = angkatanValue;
                          _usersFuture = ApiServices.fetchUserAll(
                            currentPage,
                            context,
                            angkatan: angkatan,
                            prodi: prodi,
                          );
                        });
                        _loadUsers();
                      },
                      child: Text(
                        "Simpan",
                        style: MyFont.poppins(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
