import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:flutter/material.dart';

class GrupWhatsappView extends StatefulWidget {
  const GrupWhatsappView({super.key});

  @override
  State<GrupWhatsappView> createState() => _GrupWhatsappViewState();
}

class _GrupWhatsappViewState extends State<GrupWhatsappView> {
  final List<ListGrup> items = [
    ListGrup(
      image:
          'https://kebudayaan.kemdikbud.go.id/ditwdb/wp-content/uploads/sites/9/2016/10/New-Picture-37.png',
      title: 'Jember',
      onTap: () {
        // Function to execute when Item 1 is tapped
        // Add your logic here
      },
    ),
    ListGrup(
      image:
          'https://th.bing.com/th/id/R.b7c58790d502d49d2cfa34aa3cd92210?rik=j4ffNors%2buZsXg&riu=http%3a%2f%2fwww.indoplaces.com%2ffoto%2fregion%2fkantor-bupati-bondowoso.jpg&ehk=%2b6suZxuiA4wrMvPK3pdT8hd4z0s%2ftyFnxo2OnP8cJeg%3d&risl=&pid=ImgRaw&r=0',
      title: 'Bondowoso',
      onTap: () {
        // Function to execute when Item 2 is tapped
        // Add your logic here
      },
    ),
    ListGrup(
      image:
          'https://th.bing.com/th/id/R.17a42b400a68a4dc2f32a632b90177f1?rik=RBdY2jCVV10pmw&riu=http%3a%2f%2fwww.indoplaces.com%2ffoto%2fregion%2fkantor-bupati-lumajang.jpg&ehk=3BUdk3dDjdCYoNUhiqC4BWLJvjUQ92z8lJK0tgAai6M%3d&risl=&pid=ImgRaw&r=0',
      title: 'Lumajang',
      onTap: () {
        // Function to execute when Item 2 is tapped
        // Add your logic here
      },
    ),
    ListGrup(
      image:
          'https://th.bing.com/th/id/OIP.kNBv2SS7z2wlHdXFF0OSHgHaEK?w=272&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7',
      title: 'Situbondo',
      onTap: () {
        // Function to execute when Item 2 is tapped
        // Add your logic here
      },
    ),
    ListGrup(
      image:
          'https://lh3.googleusercontent.com/-g_OJSts3rY8/VYzsoWszigI/AAAAAAAAbew/78muoKP_eds/s980/kantor-bupati-banyuwangi.jpg',
      title: 'Banyuwangi',
      onTap: () {
        // Function to execute when Item 2 is tapped
        // Add your logic here
      },
    ),
    ListGrup(
      image:
          'https://th.bing.com/th/id/OIP.hnEoKCe36oO1fOly0y3VSwHaFj?w=240&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7',
      title: 'Probolinggo',
      onTap: () {
        // Function to execute when Item 2 is tapped
        // Add your logic here
      },
    ),
    ListGrup(
      image:
          'https://th.bing.com/th/id/OIP.SvOJAX4_EvIDAQ7Ey8fZKAHaFj?w=219&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7',
      title: 'Nganjuk',
      onTap: () {
        // Function to execute when Item 2 is tapped
        // Add your logic here
      },
    ),
    ListGrup(
      image:
          'https://th.bing.com/th/id/OIP._vOVOpKCevw7fQimsC8f4gHaFj?w=249&h=186&c=7&r=0&o=5&dpr=1.1&pid=1.7',
      title: 'Madura',
      onTap: () {
        // Function to execute when Item 2 is tapped
        // Add your logic here
      },
    ),
    ListGrup(
      image:
          'https://th.bing.com/th/id/OIP.bxY2wE4ZnYVZgGvrgmLO0AHaFj?w=232&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7',
      title: 'Malang',
      onTap: () {
        // Function to execute when Item 2 is tapped
        // Add your logic here
      },
    ),
    // Add more items as needed
    ListGrup(
      image:
          'https://cloud.jpnn.com/photo/jatim/news/normal/2021/08/24/kantor-pemerintah-kota-surabaya-foto-antaraho-humas-pemkot-s-fzme.jpg',
      title: 'Surabaya',
      onTap: () {
        // Function to execute when Item 2 is tapped
        // Add your logic here
      },
    ),
    ListGrup(
      image:
          'https://www.jakarta.go.id/uploads/contents/content--20210706073038.JPG',
      title: 'Jakarta',
      onTap: () {
        // Function to execute when Item 2 is tapped
        // Add your logic here
      },
    ),
  ];
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
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: items[index].onTap,
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
                        backgroundImage: NetworkImage(items[index].image),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 15, right: 15, left: 15),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          color: Color(0xff007E6F),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Center(
                        child: Text(
                          items[index].title,
                          style: MyFont.poppins(
                              fontSize: 12,
                              color: white,
                              fontWeight: FontWeight.bold),
                        ),
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
}

class ListGrup {
  final String image;
  final String title;
  final Function() onTap;

  ListGrup({
    required this.image,
    required this.title,
    required this.onTap,
  });
}
