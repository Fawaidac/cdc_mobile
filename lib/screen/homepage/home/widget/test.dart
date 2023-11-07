import 'package:cdc_mobile/model/post_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_detail_all_post.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class MyWidget extends StatefulWidget {
  final List<PostAllModel> postList;
  int page;
  int totalPage;
  MyWidget(
      {required this.postList,
      required this.page,
      required this.totalPage,
      super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.postList.length,
      itemBuilder: (context, index) {
        if (widget.postList.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final post = widget.postList[index];
        if (index < widget.postList.length) {
          String dateTime = widget.postList[index].postAt;
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
                        backgroundImage: NetworkImage(post.uploader.foto ==
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
                            style: MyFont.poppins(fontSize: 11, color: black),
                          )
                        ],
                      )),
                      InkWell(
                        onTap: () {
                          _showDescriptionDialog(post.position, post.company,
                              post.typeJobs, post.description, post.expired);
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
                          image: NetworkImage(post.image), fit: BoxFit.cover)),
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
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
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
        } else {
          return Center(
            child: CircularProgressIndicator(),
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
