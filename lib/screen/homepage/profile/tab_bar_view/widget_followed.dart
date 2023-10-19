import 'package:cdc_mobile/model/followers_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/screen1/detail%20user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class WidgetFollowed extends StatelessWidget {
  const WidgetFollowed({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: ApiServices.getFollowed(),
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
          final followersData = snapshot.data!;
          final List<dynamic> followersList =
              followersData['followers'] as List<dynamic>? ?? [];

          return ListView.builder(
            itemCount: followersList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final followerData = followersList[index];
              final Follower follower = Follower.fromJson(followerData);

              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailUser(id: follower.id ?? ""),
                    ),
                  );
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
