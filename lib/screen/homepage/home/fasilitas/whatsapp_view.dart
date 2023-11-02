import 'package:card_loading/card_loading.dart';
import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/services/api.services.dart';
import 'package:flutter/material.dart';

class GrupWhatsappView extends StatefulWidget {
  const GrupWhatsappView({super.key});

  @override
  State<GrupWhatsappView> createState() => _GrupWhatsappViewState();
}

class _GrupWhatsappViewState extends State<GrupWhatsappView> {
  List<Map<String, dynamic>> grupWhatsAppList = [];
  bool isLoading = true;

  void fetchGrupWhatsAppData() async {
    final data = await ApiServices.fetchDataGrupWhatsApp();

    setState(() {
      isLoading = false; // Setelah data diambil, matikan loading
      if (data['data'] != null) {
        if (data['data'] is List) {
          grupWhatsAppList = List<Map<String, dynamic>>.from(data['data']);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchGrupWhatsAppData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            )),
        title: Text(
          "Grup Whatsapp",
          style: MyFont.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading == true
            ? widgetIsLoading()
            : grupWhatsAppList.isEmpty
                ? Center(
                    child: Text(
                      "No Data Available",
                      style: MyFont.poppins(fontSize: 12, color: black),
                    ),
                  )
                : GridView.builder(
                    itemCount: grupWhatsAppList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final data = grupWhatsAppList[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xff07B29D), white],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: white,
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundImage: NetworkImage(data['image']),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 15, right: 5, left: 5),
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: const BoxDecoration(
                                    color: Color(0xff007E6F),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data['name'],
                                      style: MyFont.poppins(
                                          fontSize: 12,
                                          color: white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: Color(0xff007E6F),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Gabung",
                                    style: MyFont.poppins(
                                        fontSize: 12,
                                        color: white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  GridView widgetIsLoading() {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return const CardLoading(
          height: 150,
          width: 100,
        );
      },
    );
  }
}
