import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

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
              final description = post['description'];

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
                          backgroundColor: Colors.white,
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
                              "Someone",
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
                          onPressed: () {},
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
