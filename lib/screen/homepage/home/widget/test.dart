import 'package:cdc_mobile/model/post_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/textfields.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<PostAllModel> postList = [];
  ScrollController scrollController = ScrollController();
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

// In your fetchData method
  Future<void> fetchData() async {
    try {
      final data = await ApiServices.getData(page);

      if (data is Map<String, dynamic>) {
        if (data.containsKey('total_page')) {
          setState(() {
            totalPage = data['total_page'];
            print("Total Page: $totalPage");
            print("Page : $page");
          });
        }
        final List<PostAllModel> newPosts =
            data.keys.where((key) => int.tryParse(key) != null).map((key) {
          return PostAllModel.fromJson(data[key]);
        }).toList();

        setState(() {
          postList.addAll(newPosts);
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

  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Cari postingan berdasarkan posisi...",
          keyboardType: TextInputType.text,
          inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
          isLength: 255,
          isEnable: true,
          isWhite: true,
          onTap: () {},
          onChange: (value) {
            ApiServices.searchData(value).then((searchResults) {
              setState(() {
                postList = searchResults;
                print('seach : $postList');
              });
            });
          },
          icon: Icons.search,
          controller: search,
        ),
        SizedBox(
          height: 500,
          child: ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            controller: scrollController,
            itemCount: postList.length + 1,
            itemBuilder: (context, index) {
              final itemNumber = index + 1;
              if (index < postList.length) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(10),
                  color: black,
                  child: Text(
                    '$itemNumber',
                    style: TextStyle(color: white),
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
