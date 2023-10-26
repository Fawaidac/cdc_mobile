import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cdc_mobile/model/comment_model.dart';
import 'package:cdc_mobile/model/user_model.dart';
import 'package:cdc_mobile/resource/awesome_dialog.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WidgetDetailAllPost extends StatefulWidget {
  final String image;
  final String id;
  final String description;
  final String position;
  final String company;
  final String typeJobs;
  final String expired;
  final String verified;
  final String name;
  final String profile;
  final String postAt;
  final int can;
  final bool isUser;
  List<CommentModel> commentModel;

  WidgetDetailAllPost(
      {required this.image,
      required this.description,
      required this.id,
      required this.position,
      required this.company,
      required this.typeJobs,
      required this.expired,
      required this.isUser,
      required this.verified,
      required this.name,
      required this.profile,
      required this.postAt,
      required this.can,
      required this.commentModel,
      super.key});

  @override
  State<WidgetDetailAllPost> createState() => _WidgetDetailAllPostState();
}

class _WidgetDetailAllPostState extends State<WidgetDetailAllPost> {
  List<CommentModel> comments = [];
  User? user;
  var comment = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comments = widget.commentModel;
  }

  Future<void> sendComment() async {
    final response = await ApiServices.sendComment(widget.id, comment.text);
    if (response['code'] == 201) {
      Fluttertoast.showToast(msg: "Berhasil mengomentari postingan");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } else {
      Fluttertoast.showToast(msg: response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    String dateTime = widget.postAt;
    final date = DateTime.parse(dateTime);
    initializeDateFormatting('id_ID', null);
    final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    final timeFormat = DateFormat('HH:mm');
    final formattedDate = dateFormat.format(date);
    final formattedTime = timeFormat.format(date);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            )),
        title: Text(
          "Postingan",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                          backgroundImage: NetworkImage(widget.profile ==
                                  ApiServices.baseUrlImage
                              ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                              : widget.profile),
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
                              widget.name,
                              style: MyFont.poppins(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$formattedDate, $formattedTime WIB',
                              style: MyFont.poppins(fontSize: 11, color: black),
                            )
                          ],
                        )),
                        InkWell(
                          onTap: () {
                            _showDescriptionDialog(
                                widget.position,
                                widget.company,
                                widget.typeJobs,
                                widget.description,
                                widget.expired);
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
                    height: 500,
                    margin: const EdgeInsets.only(top: 20, bottom: 0),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover)),
                    width: MediaQuery.of(context).size.width,
                  ),
                  CustomTextField(
                      controller: comment,
                      label: "Tulis Komentar...",
                      keyboardType: TextInputType.text,
                      inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter,
                      isLength: 255,
                      isEnable: true,
                      isWhite: true,
                      onTap: () => sendComment(),
                      icon: Icons.send),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        // final userData = user;
                        final User data = comment.user;
                        String dateTime = comment.createdAt.toString();
                        final date = DateTime.parse(dateTime);
                        initializeDateFormatting('id_ID', null);
                        final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
                        final timeFormat = DateFormat('HH:mm');
                        final formattedDate = dateFormat.format(date);
                        final formattedTime = timeFormat.format(date);

                        // Tambahkan pemeriksaan apakah user ada atau tidak

                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(data.foto ==
                                        ApiServices.baseUrlImage
                                    ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                    : ApiServices.baseUrlImage +
                                        (data.foto ?? "")),
                              ),
                              title: Text(
                                data.fullname ?? "",
                                style: MyFont.poppins(
                                    fontSize: 12,
                                    color: black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                comment.comment,
                                style:
                                    MyFont.poppins(fontSize: 12, color: black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    '$formattedDate, $formattedTime',
                                    style: MyFont.poppins(
                                        fontSize: 10, color: grey),
                                  )),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
