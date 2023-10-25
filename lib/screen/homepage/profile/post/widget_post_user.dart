import 'package:card_loading/card_loading.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/screen/homepage/profile/post/widget_detail_post_user.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class WidgetPostUser extends StatefulWidget {
  String name;
  String image;
  WidgetPostUser({required this.image, required this.name, super.key});

  @override
  State<WidgetPostUser> createState() => _WidgetPostUserState();
}

class _WidgetPostUserState extends State<WidgetPostUser> {
  int page = 1;
  int? totalPage;
  Future<Map<String, dynamic>>? postFuture;
  List<Map<String, dynamic>> postList = [];

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final dataAndTotalPage = await ApiServices.getPostUserLogin();
      final data = dataAndTotalPage['data'];
      print(data);
      final total = dataAndTotalPage;

      if (totalPage == null) {
        setState(() {
          totalPage = total['total_page'];
        });
      }

      if (totalPage != null && page <= totalPage!) {
        setState(() {
          postList.addAll(data);
        });
      }

      return dataAndTotalPage;
    } catch (e) {
      print("Error fetching data: $e");
      return Future.value({'data': [], 'totalPage': 0});
    }
  }

  Future<void> loadMoreData() async {
    if (totalPage != null && page < totalPage!) {
      page++;
      fetchData();
    }
  }

  @override
  void initState() {
    super.initState();
    postFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            shrinkWrap: false,
            physics: BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return CardLoading(
                height: 50,
                borderRadius: BorderRadius.circular(15),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return GridView.builder(
            itemCount: postList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final post = postList[index];
              if (index == postList.length - 1) {
                loadMoreData();
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WidgetDetailPost(
                          image: post['image'],
                          description: post['description'],
                          company: post['company'],
                          expired: post['expired'],
                          position: post['position'],
                          isUser: true,
                          typeJobs: post['type_jobs'],
                          verified: post['verified'],
                          name: widget.name,
                          profile: widget.image,
                          id: post['id'],
                          commentModel: post['comments'],
                          can: post['can_comment'],
                        ),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image:
                          NetworkImage(post['image']), // Perbarui kunci 'image'
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
