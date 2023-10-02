import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:cdc_mobile/screen/homepage/home/home.dart';
import 'package:cdc_mobile/screen/homepage/posting/posting.dart';
import 'package:cdc_mobile/screen/homepage/profile/profile.dart';
import 'package:cdc_mobile/screen/homepage/screen1/users_all.dart';
import 'package:cdc_mobile/screen/homepage/screen2/ikapj_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  List<Widget> screen = <Widget>[
    const Home(),
    const UsersAll(),
    const Posting(),
    const IkapjScreen(),
    const Profile(),
  ];

  List navbutton = [
    {
      "active": Image.asset(
        "images/active_home.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_home.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Home"
    },
    {
      "active": Image.asset(
        "images/active_graph.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_graph.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Gatau"
    },
    {
      "active": Image.asset(
        "images/active_plus.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_plus.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Posting"
    },
    {
      "active": Image.asset(
        "images/fill.png",
        height: 25,
        width: 25,
      ),
      "non_active": Image.asset(
        "images/non.png",
        height: 25,
        width: 25,
        color: primaryColor,
      ),
      "label": "Gatau"
    },
    {
      "active": Image.asset(
        "images/active_profile.png",
        height: 20,
        color: primaryColor,
        width: 20,
      ),
      "non_active": Image.asset(
        "images/non_active_profile.png",
        height: 20,
        color: primaryColor,
        width: 20,
      ),
      "label": "Profile"
    },
  ];
  void onTap(value) {
    setState(() {
      index = value;
    });
  }

  bool active = true;
  var searh = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 48,
          child: TextFormField(
            textInputAction: TextInputAction.done,
            controller: searh,
            style: MyFont.poppins(fontSize: 12, color: black),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: first,
              ),
              hintText: "Search",
              isDense: true,
              hintStyle: GoogleFonts.poppins(fontSize: 13, color: grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: first,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: first,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.transparent,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                SizedBox(
                  child: Image.asset(
                    "images/bell.png",
                    height: 20,
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  child: Image.asset(
                    "images/chats.png",
                    height: 20,
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
      body: active
          ? screen[index]
          : ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                List<Map<String, String>> users = [
                  {
                    'name': 'John Doe',
                    'job': 'Software Engineer',
                    'alamat': 'Indonesia',
                    'image':
                        'https://th.bing.com/th/id/OIP.pt5YNjPj8LATRUq63w-t6wHaEK?w=315&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7',
                  },
                  {
                    'name': 'Jane Smith',
                    'job': 'Product Manager',
                    'alamat': 'United State',
                    'image':
                        'https://th.bing.com/th/id/OIP.AytO0mQGWx8RpzBt5qWkcwHaE8?w=276&h=184&c=7&r=0&o=5&dpr=1.1&pid=1.7',
                  },
                  {
                    'name': 'Michael Johnson',
                    'job': 'UI/UX Designer',
                    'alamat': 'Korea Selatan',
                    'image':
                        'https://th.bing.com/th/id/OIP.l8SaJQUqU1rtrv_84wNzFgHaEK?w=316&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7',
                  },
                ];

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Screen3(
                        //           name: users[index]['name']!,
                        //           job: users[index]['job']!,
                        //           image: users[index]['image']!,
                        //           alamat: users[index]['alamat']!),
                        //     ));
                      },
                      child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width,
                          color: white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage(users[index]['image']!),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    users[index]['name']!,
                                    style: MyFont.poppins(
                                        fontSize: 14,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    users[index]['job']!,
                                    style: MyFont.poppins(
                                        fontSize: 12,
                                        color: black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                    Divider(
                      height: 5,
                    )
                  ],
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          unselectedLabelStyle: MyFont.poppins(
              fontSize: 12, color: grey, fontWeight: FontWeight.w300),
          selectedLabelStyle: MyFont.poppins(
              fontSize: 12, color: white, fontWeight: FontWeight.w500),
          selectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          selectedItemColor: first,
          unselectedItemColor: softgrey,
          currentIndex: index,
          onTap: onTap,
          elevation: 0,
          backgroundColor: Colors.white,
          items: List.generate(5, (index) {
            var navBtn = navbutton[index];
            return BottomNavigationBarItem(
                icon: navBtn["non_active"],
                activeIcon: navBtn["active"],
                label: navBtn["label"]);
          })),
    );
  }
}
