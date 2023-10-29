import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_quisioner.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WidgetNews extends StatefulWidget {
  const WidgetNews({Key? key}) : super(key: key);

  @override
  State<WidgetNews> createState() => _WidgetNewsState();
}

class _WidgetNewsState extends State<WidgetNews> {
  // Deklarasikan variabel untuk menampung data berita
  List<Map<String, dynamic>> newsData = [];

  @override
  void initState() {
    super.initState();
    // Panggil metode untuk mengambil data berita
    fetchNewsData();
  }

  // Metode untuk mengambil data berita
  Future<void> fetchNewsData() async {
    final data = await ApiServices.getNews();

    setState(() {
      newsData = data ?? [];
    });
  }

  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        newsData.isEmpty
            ? WidgetQuisioner()
            : SizedBox(
                height: 175,
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: newsData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: size.width - 20,
                      height: 175,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(newsData[index]['image']),
                              fit: BoxFit.cover)),
                      child: Container(
                        height: 175,
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.transparent,
                              white.withOpacity(0.5)
                            ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              newsData[index]['title'],
                              style: MyFont.poppins(
                                  fontSize: 18,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment(0, 0.60),
          child: SmoothPageIndicator(
            controller: _controller,
            count: newsData.length,
            effect: SlideEffect(
                dotWidth: 8,
                dotHeight: 8,
                activeDotColor: primaryColor,
                dotColor: Color(0xffD1E8F7)),
          ),
        ),
      ],
    );
  }
}
