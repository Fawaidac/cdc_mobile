import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cdc_mobile/model/comment_model.dart';
import 'package:cdc_mobile/resource/awesome_dialog.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/homepage.dart';
import 'package:cdc_mobile/screen/homepage/profile/post/widget_update_post.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WidgetDetailPost extends StatefulWidget {
  final String image;
  final String id;
  final String description;
  final String position;
  final String company;
  final String typeJobs;
  final String linkApply;
  final String expired;
  final String verified;
  final String name;
  final String profile;
  final int can;
  final bool isUser;
  List<CommentModel> commentModel;

  WidgetDetailPost(
      {required this.image,
      required this.description,
      required this.id,
      required this.position,
      required this.linkApply,
      required this.company,
      required this.typeJobs,
      required this.expired,
      required this.isUser,
      required this.verified,
      required this.name,
      required this.profile,
      required this.can,
      required this.commentModel,
      super.key});

  @override
  State<WidgetDetailPost> createState() => _WidgetDetailPostState();
}

class _WidgetDetailPostState extends State<WidgetDetailPost> {
  bool checkBool() {
    return widget.can == 1 ? false : true;
  }

  Future<void> handleUpdateComment(String postId) async {
    final bool option = checkBool(); // Convert bool to String
    final response = await ApiServices.nonActiveComment(postId, option);
    if (response['code'] == 200) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } else {
      print(response['message']);
    }
  }

  Future<void> handleDeletePost() async {
    final response = await ApiServices.deletePostingan(widget.id);
    if (response['code'] == 200) {
      Fluttertoast.showToast(msg: response['message']);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } else if (response['message'] == 'Ops , akun kamu belum terverifikasi') {
      // ignore: use_build_context_synchronously
      GetAwesomeDialog.showCustomDialog(
        isTouch: false,
        context: context,
        dialogType: DialogType.ERROR,
        title: "Error",
        desc:
            "ops , nampaknya akun kamu belum terverifikasi, Silahkan isi quisioner terlebih dahulu",
        btnOkPress: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        },
        btnCancelPress: () => Navigator.pop(context),
      );
    } else {
      print(response['message']);
    }
  }

  List<CommentModel> comments = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkBool();
    comments = widget.commentModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff74BCFF).withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: widget.verified != 'verified',
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: primaryColor),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(widget.profile ==
                                        ApiServices.baseUrlImage
                                    ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                    : widget.profile),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.name,
                                style:
                                    MyFont.poppins(fontSize: 12, color: black),
                              )
                            ],
                          ),
                        ),
                        if (widget.isUser == true)
                          IconButton(
                            onPressed: () {
                              showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                      MediaQuery.of(context).size.width -
                                          20, // right
                                      20,
                                      0,
                                      0),
                                  items: [
                                    PopupMenuItem<int>(
                                        value: 0,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: primaryColor,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Edit",
                                              style: MyFont.poppins(
                                                  fontSize: 12, color: black),
                                            ),
                                          ],
                                        )),
                                    PopupMenuItem<int>(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: primaryColor,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Hapus",
                                              style: MyFont.poppins(
                                                  fontSize: 12, color: black),
                                            ),
                                          ],
                                        )),
                                    PopupMenuItem<int>(
                                        value: 2,
                                        child: Row(
                                          children: [
                                            Icon(
                                              widget.can == 1
                                                  ? Icons.not_interested_sharp
                                                  : Icons.chat_outlined,
                                              color: primaryColor,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              widget.can == 1
                                                  ? "Nonaktifkan Komentar"
                                                  : "Aktifkan Komentar",
                                              style: MyFont.poppins(
                                                  fontSize: 12, color: black),
                                            ),
                                          ],
                                        )),
                                  ]).then((value) {
                                if (value != null) {
                                  if (value == 1) {
                                    GetAwesomeDialog.showCustomDialog(
                                      context: context,
                                      dialogType: DialogType.WARNING,
                                      title: "Perhatian",
                                      desc:
                                          "Apakah anda ingin menghapus postingan?",
                                      btnOkPress: () {
                                        handleDeletePost();
                                      },
                                      btnCancelPress: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  } else if (value == 2) {
                                    handleUpdateComment(
                                      widget.id,
                                    );
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdatePosting(
                                            idPost: widget.id,
                                            image: widget.image,
                                            description: widget.description,
                                            company: widget.description,
                                            expired: widget.expired,
                                            position: widget.position,
                                            typeJobs: widget.typeJobs,
                                            linkApply: widget.linkApply,
                                          ),
                                        ));
                                  }
                                }
                              });
                            },
                            icon: Icon(
                              Icons.more_vert,
                              color: black,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
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
                                widget.position,
                                style: MyFont.poppins(
                                    fontSize: 14,
                                    color: black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.company,
                                style:
                                    MyFont.poppins(fontSize: 12, color: black),
                              )
                            ],
                          ),
                        ),
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
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover)),
                    width: MediaQuery.of(context).size.width,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        useSafeArea: true,
                        context: context,
                        builder: (builder) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 15,
                              right: 15,
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom + 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  height: 8,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: grey.withOpacity(0.1),
                                  ),
                                ),

                                SizedBox(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: comments.length,
                                    itemBuilder: (context, index) {
                                      final comment = comments[index];
                                      String dateTime =
                                          comment.createdAt.toString();
                                      final date = DateTime.parse(dateTime);
                                      initializeDateFormatting('id_ID', null);
                                      final dateFormat =
                                          DateFormat('dd MMMM yyyy', 'id_ID');
                                      final timeFormat = DateFormat('HH:mm');
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
                                          "$formattedDate,  $formattedTime",
                                          style: MyFont.poppins(
                                              fontSize: 11, color: black),
                                        ), // Ganti dengan yang sesuai
                                        subtitle: Text(comment.comment,
                                            style: MyFont.poppins(
                                                fontSize: 12, color: black)),
                                      );
                                    },
                                  ),
                                ),

                                // TextField untuk menulis komentar
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          "images/comment.png",
                          height: 30,
                          color: primaryColor,
                        ),
                      ),
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

  var comment = TextEditingController();
  void _showModalSheet(BuildContext context) {
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
              Container(
                alignment: Alignment.center,
                height: 8,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: grey.withOpacity(0.1),
                ),
              ),
              // Gunakan FutureBuilder untuk menampilkan data komentar
              SizedBox(
                height: 400,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                          // Tampilkan foto profil pengguna komentar di sini
                          // comment.userProfileImage
                          ),
                      title: Text(comment.createdAt
                          .toString()), // Ganti dengan yang sesuai
                      subtitle: Text(comment.comment),
                    );
                  },
                ),
              ),

              // TextField untuk menulis komentar
              TextField(
                textInputAction: TextInputAction.done,
                controller: comment,
                style: MyFont.poppins(
                  fontSize: 14,
                  color: black,
                ),
                keyboardType: TextInputType.text,
                readOnly: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(225)
                ],
                decoration: InputDecoration(
                  hintText: "Tambahkan komentar...",
                  isDense: false,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
