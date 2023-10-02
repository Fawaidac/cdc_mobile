import 'package:cdc_mobile/model/followers_model.dart';

import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
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
          ),
        ),
      ),
      body: FutureBuilder<FollowersModel>(
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
              itemBuilder: (context, index) {
                final follower = followersList[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: first,
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
      ),
    );
  }
}
