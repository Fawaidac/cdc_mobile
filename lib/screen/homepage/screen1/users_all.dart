import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:flutter/material.dart';

class UsersAll extends StatefulWidget {
  const UsersAll({super.key});

  @override
  State<UsersAll> createState() => _UsersAllState();
}

class _UsersAllState extends State<UsersAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: primaryColor),
                      borderRadius: BorderRadius.circular(10),
                      color: white),
                  child: Text(
                    "Angkatan",
                    style: MyFont.poppins(fontSize: 12, color: primaryColor),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: primaryColor),
                      borderRadius: BorderRadius.circular(10),
                      color: white),
                  child: Text(
                    "Jurusan",
                    style: MyFont.poppins(fontSize: 12, color: primaryColor),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: primaryColor),
                      borderRadius: BorderRadius.circular(10),
                      color: white),
                  child: Text(
                    "Program Studi",
                    style: MyFont.poppins(fontSize: 12, color: primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: white),
                  child: Column(
                    children: [],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
