import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/home/widget/widget_top_20_alumni.dart';
import 'package:flutter/material.dart';

class WidgetTopAlumni extends StatelessWidget {
  const WidgetTopAlumni({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 100,
        child: ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Top20Alumni(),
                      ));
                }
              },
              child: Container(
                height: 100,
                width: 270,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index == 0)
                                  Text(
                                    "Top 20 Alumni",
                                    style: MyFont.poppins(
                                        fontSize: 14,
                                        color: white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                if (index == 1)
                                  Text(
                                    "Top 20 Salary",
                                    style: MyFont.poppins(
                                        fontSize: 14,
                                        color: white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                if (index == 0)
                                  Text(
                                    "Alumni terbaik lulusan Politeknik Negeri Jember",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: MyFont.poppins(
                                        fontSize: 12,
                                        color: white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                if (index == 1)
                                  Text(
                                    "Salary teratas lulusan Politeknik Negeri Jember",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: MyFont.poppins(
                                        fontSize: 12,
                                        color: white,
                                        fontWeight: FontWeight.normal),
                                  )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
