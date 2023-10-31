import 'package:cdc_mobile/model/user_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:cdc_mobile/screen/homepage/alumni/detail%20user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AlumniView extends StatefulWidget {
  const AlumniView({super.key});

  @override
  State<AlumniView> createState() => _AlumniViewState();
}

class _AlumniViewState extends State<AlumniView> {
  List<Alumni> alumniList = [];
  List<Alumni> filterAlumniList = [];
  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int totalPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  String? selectedProdi;
  int? angkatan;
  bool showCloseIcon = false;
  bool showCloseIconAngkatan = false;

  @override
  void initState() {
    super.initState();
    fetchDataAlumni();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!isLoading &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        hasMore) {
      if (currentPage < totalPage) {
        currentPage = currentPage + 1;
        fetchDataAlumni();
        print(currentPage);
      } else {
        setState(() {
          hasMore = false;
        });
      }
    } else {
      print('dont call');
    }
  }

  Future<void> fetchDataAlumni() async {
    if (!isLoading && hasMore) {
      try {
        setState(() {
          isLoading = true;
        });
        alumniList.clear();
        // Tambahkan pernyataan ini
        final data = await ApiServices.fetchAlumniAll(
          currentPage,
          context,
        );

        if (data is Map<String, dynamic>) {
          if (data.containsKey('total_page')) {
            totalPage = data['total_page'];
            print("Total Page: $totalPage");
            print("Page : $currentPage");
          }
          final List<Alumni> alumni =
              data.keys.where((key) => int.tryParse(key) != null).map((key) {
            return Alumni.fromJson(data[key]);
          }).toList();
          if (alumniList.length < 10) {
            hasMore = false;
          }
          setState(() {
            alumniList.addAll(alumni);
          });

          setState(() {});
        } else {
          print("Response data is not in the expected format.");
        }
        setState(() {});
      } catch (e) {
        print("Error fetching data: $e");
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  var search = TextEditingController();
  bool _isAscending = true;
// Di dalam metode _toggleSortOrder
  void _toggleSortOrder() {
    setState(() {
      _isAscending = !_isAscending;
      if (_isAscending) {
        // Urutkan alumni berdasarkan nama dari A-Z (ascending)
        alumniList.sort((a, b) => a.user.fullname!.compareTo(b.user.fullname!));
      } else {
        // Urutkan alumni berdasarkan nama dari Z-A (descending)
        alumniList.sort((a, b) => b.user.fullname!.compareTo(a.user.fullname!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
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
        child: Column(
          children: [
            CustomTextField(
              label: "   Cari Alumni",
              keyboardType: TextInputType.text,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
              isLength: 255,
              isEnable: true,
              isWhite: true,
              onTap: () {},
              onChange: (value) {
                setState(() {
                  filterAlumniList = alumniList
                      .where((alumni) => alumni.user.fullname!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              icon: Icons.search,
              controller: search,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _toggleSortOrder,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: white,
                      ),
                      child: Center(
                        child: Text(
                          _isAscending ? "A - Z" : "Z - A",
                          style:
                              MyFont.poppins(fontSize: 12, color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            showCloseIcon == false
                                ? "Program Studi"
                                : selectedProdi ?? "",
                            style: MyFont.poppins(
                                fontSize: 12, color: primaryColor),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (showCloseIcon == true)
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  selectedProdi = null;
                                  showCloseIcon = false;
                                });
                                alumniList.clear();
                                final data = await ApiServices.fetchAlumniAll(
                                    currentPage, context,
                                    prodi: selectedProdi, angkatan: angkatan);

                                if (data is Map<String, dynamic>) {
                                  if (data.containsKey('total_page')) {
                                    totalPage = data['total_page'];
                                    print("Total Page: $totalPage");
                                    print("Page : $currentPage");
                                  }
                                  final List<Alumni> alumni = data.keys
                                      .where((key) => int.tryParse(key) != null)
                                      .map((key) {
                                    return Alumni.fromJson(data[key]);
                                  }).toList();
                                  if (alumniList.length < 10) {
                                    hasMore = false;
                                  }
                                  setState(() {
                                    alumniList.addAll(alumni);
                                  });
                                } else {
                                  print(
                                      "Response data is not in the expected format.");
                                }
                              },
                              child: Icon(
                                Icons.close,
                                size: 15,
                                color: black,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            showCloseIconAngkatan == false
                                ? "Angkatan"
                                : angkatan.toString(),
                            style: MyFont.poppins(
                                fontSize: 12, color: primaryColor),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (showCloseIconAngkatan == true)
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  angkatan = null;
                                  showCloseIconAngkatan = false;
                                });
                                alumniList.clear();
                                final data = await ApiServices.fetchAlumniAll(
                                    currentPage, context,
                                    prodi: selectedProdi, angkatan: angkatan);

                                if (data is Map<String, dynamic>) {
                                  if (data.containsKey('total_page')) {
                                    totalPage = data['total_page'];
                                    print("Total Page: $totalPage");
                                    print("Page : $currentPage");
                                  }
                                  final List<Alumni> alumni = data.keys
                                      .where((key) => int.tryParse(key) != null)
                                      .map((key) {
                                    return Alumni.fromJson(data[key]);
                                  }).toList();
                                  if (alumniList.length < 10) {
                                    hasMore = false;
                                  }
                                  setState(() {
                                    alumniList.addAll(alumni);
                                  });
                                } else {
                                  print(
                                      "Response data is not in the expected format.");
                                }
                              },
                              child: Icon(
                                Icons.close,
                                size: 15,
                                color: black,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: search.text.isNotEmpty
                    ? filterAlumniList.length
                    : alumniList.length + 1,
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index < alumniList.length) {
                    final data = search.text.isNotEmpty
                        ? filterAlumniList[index]
                        : alumniList[index];
                    final educations = data.educations;
                    final filteredEducations = educations
                        .where((education) =>
                            education.perguruan == 'Politeknik Negeri Jember')
                        .toList();
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailUser(
                                id: data.user.id ?? "",
                              ),
                            ));
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: grey.withOpacity(0.2),
                                  image: DecorationImage(
                                      image: NetworkImage(data.user.foto ==
                                              ApiServices.baseUrlImage
                                          ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                          : data.user.foto ?? ""),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    data.user.fullname ?? "",
                                    style: MyFont.poppins(
                                        fontSize: 14,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                for (var education in filteredEducations)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Jurusan : ${education.jurusan}',
                                          style: MyFont.poppins(
                                              fontSize: 12,
                                              color: black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          'Program studi : ${education.prodi}',
                                          style: MyFont.poppins(
                                              fontSize: 12, color: black),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            '${education.tahunMasuk}',
                                            textAlign: TextAlign.center,
                                            style: MyFont.poppins(
                                                fontSize: 12, color: white),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            // alignment: Alignment.bottomRight,
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 15),
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
                                                  fontWeight: FontWeight.bold),
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
                      ),
                    );
                  } else {
                    return Center(
                      child:
                          hasMore ? CircularProgressIndicator() : Container(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
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
                            onTap: () async {
                              Navigator.pop(context);
                              setState(() {
                                selectedProdi = prodiList[index]['nama_prodi'];
                                print(selectedProdi);
                                showCloseIcon = true;
                              });
                              alumniList.clear();
                              final data = await ApiServices.fetchAlumniAll(
                                  currentPage, context,
                                  prodi: selectedProdi, angkatan: angkatan);

                              if (data is Map<String, dynamic>) {
                                if (data.containsKey('total_page')) {
                                  totalPage = data['total_page'];
                                  print("Total Page: $totalPage");
                                  print("Page : $currentPage");
                                }
                                final List<Alumni> alumni = data.keys
                                    .where((key) => int.tryParse(key) != null)
                                    .map((key) {
                                  return Alumni.fromJson(data[key]);
                                }).toList();
                                if (alumniList.length < 10) {
                                  hasMore = false;
                                }
                                setState(() {
                                  alumniList.addAll(alumni);
                                });
                              } else {
                                print(
                                    "Response data is not in the expected format.");
                              }
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
                  hintText: "Angkatan",
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
                      onPressed: () async {
                        Navigator.pop(context);
                        setState(() {
                          int angkatanValue = int.parse(tahun.text);
                          angkatan = angkatanValue;
                          showCloseIconAngkatan = true;
                        });
                        alumniList.clear();
                        final data = await ApiServices.fetchAlumniAll(
                            currentPage, context,
                            angkatan: angkatan);

                        if (data is Map<String, dynamic>) {
                          if (data.containsKey('total_page')) {
                            totalPage = data['total_page'];
                            print("Total Page: $totalPage");
                            print("Page : $currentPage");
                          }
                          final List<Alumni> alumni = data.keys
                              .where((key) => int.tryParse(key) != null)
                              .map((key) {
                            return Alumni.fromJson(data[key]);
                          }).toList();
                          if (alumniList.length < 10) {
                            hasMore = false;
                          }
                          setState(() {
                            alumniList.addAll(alumni);
                          });
                        } else {
                          print("Response data is not in the expected format.");
                        }
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
