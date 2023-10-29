import 'package:cdc_mobile/model/quisioner_check_model.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/home/quisioner/identitas_section.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_news.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_post.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_quisioner.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_top_alumni.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WidgetNews(),
            WidgetTopAlumni(),
            SizedBox(child: WidgetPost()),
          ],
        ),
      ),
    );
  }
}
