import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/profile/post/widget_detail_post_user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class WidgetPost extends StatefulWidget {
  const WidgetPost({Key? key});

  @override
  State<WidgetPost> createState() => _WidgetPostState();
}

class _WidgetPostState extends State<WidgetPost> {
  int page = 1;
  int? totalPage;
  Future<Map<String, dynamic>>? postFuture; // Change the type here
  List<Map<String, dynamic>> postList = [];

  Future<Map<String, dynamic>> fetchData() async {
    // Change the return type here
    try {
      final dataAndTotalPage = await ApiServices.getData(page);
      final data = dataAndTotalPage['data'];
      print(data);
      // Set totalPage only if it's not null
      if (totalPage == null) {
        setState(() {
          totalPage = dataAndTotalPage['totalPage'];
        });
      }

      if (totalPage != null && page <= totalPage!) {
        setState(() {
          postList.addAll(data);
        });
      }

      return dataAndTotalPage; // Return the data
    } catch (e) {
      print("Error fetching data: $e");
      return Future.value({'data': [], 'totalPage': 0});
    }
  }

  @override
  void initState() {
    super.initState();
    postFuture = fetchData(); // Initialize the Future here
  }

  Future<void> loadMoreData() async {
    if (totalPage != null && page < totalPage!) {
      page++;
      fetchData();
    }
  }

  var commentController = TextEditingController();
  String formatTimeAgoo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} detik yang lalu";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} menit yang lalu";
    } else if (difference.inHours < 1) {
      return "${difference.inHours} jam yang lalu";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} jam yang lalu";
    } else if (difference.inHours < 48) {
      return "1 hari yang lalu";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} hari yang lalu";
    } else if (difference.inDays < 28) {
      final weeks = difference.inDays ~/ 7;
      return "$weeks minggu yang lalu";
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return "$months bulan yang lalu";
    } else {
      final years = difference.inDays ~/ 365;
      return "$years tahun yang lalu";
    }
  }

  String formatTimeAgo(int hours, int minutes) {
    if (hours >= 24) {
      final days = hours ~/ 24;
      return "$days hari yang lalu";
    } else if (hours > 0) {
      final remainingMinutes = minutes % 60;
      return "$hours jam $remainingMinutes menit yang lalu";
    } else if (minutes > 0) {
      return "$minutes menit yang lalu";
    } else {
      return "Baru saja";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: postFuture, // Use the pre-initialized Future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: postList.length,
            itemBuilder: (context, index) {
              final post = postList[index];

              if (index == postList.length - 1) {
                loadMoreData();
              }

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff74BCFF).withOpacity(0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(post['uploader'].foto ==
                                  ApiServices.baseUrlImage
                              ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                              : post['uploader'].foto),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post['uploader'].fullname,
                              style: MyFont.poppins(fontSize: 12, color: black),
                            )
                          ],
                        ))
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  post['position'],
                                  style: MyFont.poppins(
                                      fontSize: 14,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  post['company'],
                                  style: MyFont.poppins(
                                      fontSize: 12, color: black),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showDescriptionDialog(
                                  post['position'],
                                  post['company'],
                                  post['type_jobs'],
                                  post['description'],
                                  post['expired']);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(post['image']),
                              fit: BoxFit.cover)),
                      width: MediaQuery.of(context).size.width,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (builder) {
                                return SingleChildScrollView(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: 15,
                                    right: 15,
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        height: 8,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: grey.withOpacity(0.1),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 400,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: post['comments'].length,
                                          itemBuilder: (context, index) {
                                            initializeDateFormatting(
                                                'id_ID', null);
                                            final comment =
                                                post['comments'][index];
                                            String dateTime =
                                                comment.createdAt.toString();
                                            final date =
                                                DateTime.parse(dateTime);
                                            initializeDateFormatting(
                                                'id_ID', null);
                                            final dateFormat = DateFormat(
                                                'dd MMMM yyyy', 'id_ID');
                                            final timeFormat =
                                                DateFormat('HH:mm');
                                            final formattedDate =
                                                dateFormat.format(date);
                                            final formattedTime =
                                                timeFormat.format(date);

                                            return ListTile(
                                              leading: CircleAvatar(
                                                  // Tampilkan foto profil pengguna komentar di sini
                                                  // comment.userProfileImage
                                                  ),
                                              title: Text(
                                                "$formattedDate $formattedTime",
                                                style: MyFont.poppins(
                                                    fontSize: 11, color: black),
                                              ), // Ganti dengan yang sesuai
                                              subtitle: Text(comment.comment,
                                                  style: MyFont.poppins(
                                                      fontSize: 12,
                                                      color: black)),
                                            );
                                          },
                                        ),
                                      ),

                                      // TextField untuk menulis komentar
                                      TextField(
                                        textInputAction: TextInputAction.done,
                                        controller: commentController,
                                        style: MyFont.poppins(
                                          fontSize: 14,
                                          color: black,
                                        ),
                                        keyboardType: TextInputType.text,
                                        readOnly: false,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(225)
                                        ],
                                        decoration: InputDecoration(
                                          hintText: "Tambahkan komentar...",
                                          isDense: false,
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: primaryColor)),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.chat_outlined,
                            color: primaryColor,
                          )),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  void _showDescriptionDialog(String position, String company, String typeJobs,
      String description, String expired) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                position,
                style: MyFont.poppins(
                    fontSize: 14, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                company,
                style: MyFont.poppins(
                    fontSize: 12, color: black, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jenis Pekerjaan",
                            style: MyFont.poppins(fontSize: 12, color: black),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: white),
                            child: Text(
                              typeJobs,
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.send_rounded,
                          color: black,
                        ),
                        Text(
                          "Kunjungi",
                          style: MyFont.poppins(fontSize: 12, color: black),
                        )
                      ],
                    )
                  ],
                ),
                Text(
                  "Deskripsi",
                  style: MyFont.poppins(fontSize: 12, color: black),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: white),
                  child: Text(
                    description,
                    style: MyFont.poppins(fontSize: 12, color: black),
                  ),
                ),
                Text(
                  "Ditutup",
                  style: MyFont.poppins(fontSize: 12, color: black),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: white),
                  child: Text(
                    expired,
                    style: MyFont.poppins(fontSize: 12, color: black),
                  ),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Sesuaikan dengan radius yang Anda inginkan
          ),
        );
      },
    );
  }
}
