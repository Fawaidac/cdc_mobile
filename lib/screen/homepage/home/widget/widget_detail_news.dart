import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';

class WidgetDetailNews extends StatelessWidget {
  final Map<String, dynamic> newsItem;

  WidgetDetailNews({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    String dateTime = newsItem['updated_at'];
    final date = DateTime.parse(dateTime);
    initializeDateFormatting('id_ID', null);
    final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    final timeFormat = DateFormat('HH:mm');
    final formattedDate = dateFormat.format(date);
    final formattedTime = timeFormat.format(date);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            )),
        centerTitle: true,
        title: Text(
          "Berita",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(newsItem['title'],
                  style: MyFont.poppins(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(newsItem['image']),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
              child: Text(
                '$formattedDate, $formattedTime',
                style: MyFont.poppins(fontSize: 12, color: grey),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Html(
                  data: newsItem['description'],
                )),
          ],
        ),
      ),
    );
  }
}
