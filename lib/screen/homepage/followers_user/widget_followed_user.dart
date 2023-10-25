import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/model/user.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/alumni/detail%20user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class WidgetFollowedUser extends StatefulWidget {
  String id;
  WidgetFollowedUser({required this.id, super.key});

  @override
  State<WidgetFollowedUser> createState() => _WidgetFollowedUserState();
}

class _WidgetFollowedUserState extends State<WidgetFollowedUser> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserFollowedInfo>(
      future: ApiServices.fetchUserFollowed(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          final followersModel = snapshot.data!;
          // final totalFollowers = followersModel.totalFollowers;
          final followersList = followersModel.followed;

          return ListView.builder(
            itemCount: followersModel.followed!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final follower = followersList![index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailUser(id: follower.id ?? ""),
                      ));
                },
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: primaryColor,
                ),
                title: Text(
                  follower.fullname ?? "",
                  style: MyFont.poppins(fontSize: 12, color: black),
                ),
              );
            },
          );
        }
      },
    );
  }
}
