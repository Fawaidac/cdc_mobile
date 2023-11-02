import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:cdc_mobile/screen/lupa_sandi/lupa_sandi_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LupaSandiView extends StatefulWidget {
  const LupaSandiView({super.key});

  @override
  State<LupaSandiView> createState() => _LupaSandiViewState();
}

class _LupaSandiViewState extends State<LupaSandiView> {
  var email = TextEditingController();
  LupaSandiController controller = LupaSandiController();
  void checkRecovery() async {
    if (email.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Silahkan isi email anda');
    } else {
      controller.handleRecovery(email.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Atur Ulang Sandi",
              style: MyFont.poppins(fontSize: 24, color: black),
            ),
            Text(
              "Masukan email yang ditautkan di email anda",
              style: MyFont.poppins(fontSize: 12, color: black),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
                controller: email,
                label: "Email",
                isEnable: true,
                keyboardType: TextInputType.emailAddress,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
                icon: Icons.mail_rounded),
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
                  onPressed: () {
                    checkRecovery();
                  },
                  child: Text('Verifikasi',
                      style: MyFont.poppins(
                        fontSize: 14,
                        color: white,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
