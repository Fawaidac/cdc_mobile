import 'package:cdc_mobile/model/post_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_detail_all_post.dart';
import 'package:cdc_mobile/screen/homepage/profile/post/widget_detail_post_user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class WidgetPost extends StatefulWidget {
  const WidgetPost({Key? key});

  @override
  State<WidgetPost> createState() => _WidgetPostState();
}

class _WidgetPostState extends State<WidgetPost> {
  ScrollController scrollController = ScrollController();
  int page = 1;
  int totalPage = 1;
  


  Future<Map<String, dynamic>>? postFuture;
  List<PostAllModel> postList = [];
  bool isLoading = false;

  Future<Map<String, dynamic>> fetchData(int page) async {
    try {
      final data = await ApiServices.getData(page);
      if (data.containsKey('totalPage')) {
        totalPage = data['totalPage'];
        print("Total Page: $totalPage");
      }
      return data;
    } catch (e) {
      print("Error fetching data: $e");
      return {
        "postList": [],
        "totalPage": 0,
        "totalItem": 0,
      };
    }
  }

  Future<void> loadMoreData() async {
    if (totalPage != null && page < totalPage!) {
      page++;
      print("Loading page $page");
      final newData = await fetchData(page);
      if (newData['postList'].isNotEmpty) {
        setState(() {
          postList.addAll(newData['postList']);
        });
      } else {}
      print("Loaded page $page");
    }
  }

  @override
  void initState() {
    super.initState();
    postFuture = fetchData(page);
  }

  var search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
            controller: search,
            label: "Cari postingan berdasarkan posisi...",
            keyboardType: TextInputType.text,
            inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            isLength: 255,
            isEnable: true,
            isWhite: true,
            onTap: () {},
            onChange: (value) {
              ApiServices.searchData(value).then((searchResults) {
                setState(() {
                  postList = searchResults;
                  print('seach : $postList');
                });
              });
            },
            icon: Icons.search),
        FutureBuilder<Map<String, dynamic>>(
          future: postFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (page == 1) {
                postList = snapshot.data?['postList'] ?? [];
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  final post = postList[index];

                  if (index == postList.length - 1 && page < totalPage!) {
                    loadMoreData();
                  }

                  String dateTime = post.postAt;
                  final date = DateTime.parse(dateTime);
                  initializeDateFormatting('id_ID', null);
                  final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
                  final timeFormat = DateFormat('HH:mm');
                  final formattedDate = dateFormat.format(date);
                  final formattedTime = timeFormat.format(date);

                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(post
                                            .uploader.foto ==
                                        ApiServices.baseUrlImage
                                    ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                    : post.uploader.foto ?? ""),
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
                                    post.uploader.fullname ?? "",
                                    style: MyFont.poppins(
                                        fontSize: 12,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '$formattedDate, $formattedTime',
                                    style: MyFont.poppins(
                                        fontSize: 11, color: black),
                                  )
                                ],
                              )),
                              InkWell(
                                onTap: () {
                                  _showDescriptionDialog(
                                      post.position,
                                      post.company,
                                      post.typeJobs,
                                      post.description,
                                      post.expired);
                                },
                                child: Icon(
                                  Icons.info_outline,
                                  color: black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          height: 500,
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(post.image),
                                  fit: BoxFit.cover)),
                          width: MediaQuery.of(context).size.width,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WidgetDetailAllPost(
                                    image: post.image,
                                    description: post.description,
                                    id: post.id,
                                    position: post.position,
                                    company: post.company,
                                    typeJobs: post.typeJobs,
                                    expired: post.expired,
                                    isUser: false,
                                    linkApply: post.linkApply,
                                    verified: post.verified,
                                    name: post.uploader.fullname ?? "",
                                    profile: post.uploader.foto ?? "",
                                    can: post.canComment,
                                    postAt: post.postAt,
                                    commentModel: post.comments,
                                  ),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                "images/comment.png",
                                height: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: ReadMoreText(
                              post.description,
                              trimLines: 2,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: "Baca Selengkapnya",
                              trimExpandedText: "...Lebih Sedikit",
                              lessStyle: MyFont.poppins(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                              moreStyle: MyFont.poppins(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ))
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
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
