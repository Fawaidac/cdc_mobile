import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:cdc_mobile/screen/aktifasi_akun/aktifasi_akun_view.dart';
import 'package:cdc_mobile/screen/login/login_view.dart';
import 'package:cdc_mobile/screen/verifikasi/verifikasi_controller.dart';
import 'package:cdc_mobile/screen/verifikasi/verifikasi_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifikasiView extends StatefulWidget {
  const VerifikasiView({super.key});

  @override
  State<VerifikasiView> createState() => _VerifikasiViewState();
}

class _VerifikasiViewState extends State<VerifikasiView> {
  var nimOrEmail = TextEditingController();
  final controller = VerifikasiController();

  void checkVerifikasi() async {
    if (nimOrEmail.text.isEmpty) {
      Fluttertoast.showToast(msg: "Nim atau Email harus diisi");
    } else {
      await controller.handleVerifikasi(nimOrEmail.text, context);
    }
  }

  void update() async {
    await VerifikasiServices.update();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                      MediaQuery.of(context).size.width - 20, // right
                      20,
                      0,
                      0),
                  items: [
                    PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(
                              Icons.login,
                              color: primaryColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Aktifasi akun",
                              style: MyFont.poppins(fontSize: 12, color: black),
                            ),
                          ],
                        )),
                  ]).then((value) {
                if (value != null) {
                  if (value == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AktifasiAkunView(),
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Verifikasi Alumni",
                style: MyFont.poppins(
                    fontSize: 24, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Masukan NIM / Email anda",
                style: MyFont.poppins(fontSize: 12, color: black),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                  controller: nimOrEmail,
                  label: "Nim / Email",
                  isEnable: true,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.badge),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 45),
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [second, first]),
                      borderRadius: BorderRadius.circular(15)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () => checkVerifikasi(),
                    child: Text('Verifikasi',
                        style: MyFont.poppins(
                          fontSize: 14,
                          color: white,
                        )),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah memiliki akun? ",
                    style: MyFont.poppins(fontSize: 12, color: black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ));
                    },
                    child: Text(
                      "Masuk",
                      style: MyFont.poppins(
                          fontSize: 12,
                          color: first,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
