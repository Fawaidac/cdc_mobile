import 'package:cdc_mobile/model/followers_model.dart';

import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/profile/tab_bar_view/widget_followers.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class Followers extends StatefulWidget {
  const Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Column(
              children: [
                Container(
                  color: white,
                  margin: const EdgeInsets.all(0),
                  child: TabBar(
                      unselectedLabelColor: grey,
                      labelColor: primaryColor,
                      labelStyle: MyFont.poppins(
                          fontSize: 12,
                          color: black,
                          fontWeight: FontWeight.bold),
                      unselectedLabelStyle: MyFont.poppins(
                          fontSize: 12,
                          color: grey,
                          fontWeight: FontWeight.w500),
                      isScrollable: false,
                      indicatorColor: primaryColor,
                      tabs: const [
                        Tab(text: "Pengikut"),
                        Tab(text: "Diikuti"),
                      ]),
                ),
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TabBarView(children: [
                    SizedBox(
                      child: Column(
                        children: [WidgetFollowers()],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [WidgetFollowers()],
                      ),
                    ),
                  ]),
                ))
              ],
            ),
          )),
    );
  }
}
