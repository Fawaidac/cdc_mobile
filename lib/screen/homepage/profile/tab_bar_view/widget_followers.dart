import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/screen1/deatil%20user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class WidgetFollowers extends StatelessWidget {
  const WidgetFollowers({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FollowersModel>(
      future: ApiServices.getFollowers(),
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
          final followersList = followersModel.followers;

          return ListView.builder(
            itemCount: followersList!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final follower = followersList[index];
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
