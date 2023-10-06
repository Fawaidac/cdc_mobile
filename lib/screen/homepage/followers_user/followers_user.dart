import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/followers_user/widget_followed_user.dart';
import 'package:cdc_mobile/screen/homepage/followers_user/widget_followers_user.dart';
import 'package:flutter/material.dart';

class FollowersUser extends StatefulWidget {
  String id;
  FollowersUser({required this.id, super.key});

  @override
  State<FollowersUser> createState() => _FollowersUserState();
}

class _FollowersUserState extends State<FollowersUser> {
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
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TabBarView(children: [
                    SizedBox(
                        child: Column(
                      children: [WidgetFollowersUser(id: widget.id)],
                    )),
                    SizedBox(
                      child: Column(
                        children: [WidgetFollowedUser(id: widget.id)],
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
