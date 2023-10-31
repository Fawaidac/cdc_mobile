import 'package:cdc_mobile/model/post_model.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/test.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_news.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_top_alumni.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class HomeView2 extends StatefulWidget {
  const HomeView2({super.key});

  @override
  State<HomeView2> createState() => _HomeView2State();
}

class _HomeView2State extends State<HomeView2> {
  ScrollController scrollController = ScrollController();
  var search = TextEditingController();
  List<PostAllModel> postList = [];
  int page = 1;
  int totalPage = 1;

  @override
  void initState() {
    super.initState();
    fetchData();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print('call');
      if (page < totalPage) {
        page = page + 1;
        fetchData();
        print(page);
      }
    } else {
      print('dont call');
    }
  }

  void fetchData() async {
    try {
      final data = await ApiServices.getData(page);

      // ignore: unnecessary_type_check
      if (data is Map<String, dynamic>) {
        if (data.containsKey('total_page')) {
          setState(() {
            totalPage = data['total_page'];
          });
        }
        final List<PostAllModel> newPosts =
            data.keys.where((key) => int.tryParse(key) != null).map((key) {
          return PostAllModel.fromJson(data[key]);
        }).toList();

        setState(() {
          postList.addAll(newPosts); // Initialize postList with all data
        });
      } else {
        print("Response data is not in the expected format.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(
          height: 20,
        ),
        const WidgetNews(),
        const WidgetTopAlumni(),
        MyWidget(postList: postList, page: page, totalPage: totalPage)
      ],
    );
  }
}
