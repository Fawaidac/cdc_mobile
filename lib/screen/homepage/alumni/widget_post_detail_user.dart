import 'dart:convert';

import 'package:cdc_mobile/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cdc_mobile/model/user_model.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetPostDetailUser extends StatefulWidget {
  final String userId;

  WidgetPostDetailUser({required this.userId, Key? key}) : super(key: key);

  @override
  _WidgetPostDetailUserState createState() => _WidgetPostDetailUserState();
}

class _WidgetPostDetailUserState extends State<WidgetPostDetailUser> {
  int currentPage = 1;
  int totalPage = 1;

  List postList = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData(widget.userId);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('call');
      if (currentPage < totalPage) {
        currentPage = currentPage + 1;
        fetchData(widget.userId);
      }
    } else {
      print('dont call');
    }
  }

  Future<void> fetchData(String user) async {
    String url =
        '${ApiServices.baseUrl}/user/post/detail/$user?page=$currentPage';
    print(url);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final dataPost = data['data']['posts'] as List;
      final datatotalPage = data['data']['pagination']['total_page'];
      setState(() {
        postList = postList + dataPost;
        totalPage = datatotalPage;
      });
    } else {
      print('error');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      controller: _scrollController,
      itemBuilder: (context, index) {
        if (index < postList.length) {
          final post = postList[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(post['image']), // Update the key to 'image'
                fit: BoxFit.cover,
              ),
            ),
          );
        }
      },
      itemCount: postList.length + 1,
    );
  }
}
