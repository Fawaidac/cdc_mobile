import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LupaSandi extends StatefulWidget {
  const LupaSandi({super.key});

  @override
  State<LupaSandi> createState() => _LupaSandiState();
}

class _LupaSandiState extends State<LupaSandi> {
  var email = TextEditingController();
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
                    // handleLogin();
                  },
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
                  "Tidak menerima pesan ? ",
                  style: MyFont.poppins(fontSize: 12, color: black),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Kirim Ulang ",
                    style: MyFont.poppins(
                        fontSize: 12,
                        color: first,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Center(
              child: Text(
                "Harap tunggu kode dalam 00:30s",
                style: MyFont.poppins(fontSize: 12, color: grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
