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
import 'package:readmore/readmore.dart';

class WidgetDetailAllPost extends StatefulWidget {
  final String image;
  final String id;
  final String description;
  final String position;
  final String company;
  final String linkApply;
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
      required this.linkApply,
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

  Future<void> deleteComment(String idComment) async {
    final response = await ApiServices.deleteComment(widget.id, idComment);
    if (response['code'] == 200) {
      Fluttertoast.showToast(msg: "Berhasil menghapus komentar");
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
                        Column(
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
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.verified != 'verified',
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(color: primaryColor),
                      child: Column(
                        children: [
                          Visibility(
                            visible: widget.verified != 'verified',
                            child: Text(
                              "! Postingan ini belum terverifikasi ${widget.verified}",
                              style: MyFont.poppins(fontSize: 12, color: white),
                            ),
                          )
                        ],
                      ),
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.position,
                          style: MyFont.poppins(
                              fontSize: 14,
                              color: black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.company,
                          style: MyFont.poppins(fontSize: 12, color: black),
                        ),
                        const Divider(
                          height: 50,
                        ),
                        Text(
                          "Jenis Pekerjaan",
                          style: MyFont.poppins(
                              fontSize: 12,
                              color: black,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffF2F2F2)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.typeJobs,
                                style:
                                    MyFont.poppins(fontSize: 12, color: black),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ditutup",
                                  style: MyFont.poppins(
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xffF2F2F2)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.expired,
                                        style: MyFont.poppins(
                                            fontSize: 12, color: black),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.send,
                                  color: black,
                                  size: 20,
                                ),
                                Text(
                                  "Kunjungi",
                                  style: MyFont.poppins(
                                      fontSize: 12, color: black),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Deskripsi",
                          style: MyFont.poppins(
                              fontSize: 12,
                              color: black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReadMoreText(
                          widget.description,
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
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.isUser == false,
                    child: CustomTextField(
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
                  ),
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
                              onTap: () {
                                _showModalSheet(context, comment.id);
                              },
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

  void _showModalSheet(BuildContext context, String idComment) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 10,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.delete, color: black),
                title: Text(
                  "Hapus Komentar",
                  style: MyFont.poppins(fontSize: 12, color: black),
                ),
                onTap: () => deleteComment(idComment),
              )
            ],
          ),
        );
      },
    );
  }
}
