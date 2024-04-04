import 'package:flutter/material.dart';
import 'package:flutter_finalproject/Views/search_screen/search_screen.dart';
import 'package:flutter_finalproject/consts/colors.dart';
import 'package:flutter_finalproject/consts/images.dart';
import 'package:get/get.dart';
import '../cart_screen/cart_screen.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  int selectedCardIndex = 0; // เก็บ index ของการ์ดที่ถูกเลือก

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: whiteColor,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: IconButton(
                icon: Image.asset(
                  icSearch,
                  width: 23,
                ),
                onPressed: () {
                  showGeneralDialog(
                    barrierLabel: "Barrier",
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionDuration: const Duration(milliseconds: 300),
                    context: context,
                    pageBuilder: (_, __, ___) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          child: const SearchScreenPage(),
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                        ),
                      );
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return SlideTransition(
                        position: Tween(
                                begin: const Offset(0, -1),
                                end: const Offset(0, 0))
                            .animate(anim1),
                        child: child,
                      );
                    },
                  );
                },
              ),
            ),
            title: Center(
              child: Image.asset(icLogoOnTop, height: 40),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                  icon: Image.asset(
                    icCart,
                    width: 21,
                  ),
                  onPressed: () {
                    Get.to(() => const CartScreen());
                  },
                ),
              ),
            ],
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 75,
                ),
                buildCardSetTop(),
                SizedBox(height: 5),
                buildCardSetBottom(),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'เหมาะสมกับคุณมาก ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardSetTop() {
    return Container(
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10, // จำนวนการ์ด
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 300.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/product${index % 3 + 1}.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildCardSetBottom() {
  return Container(
    height: 250.0, // กำหนดความสูงของ container ที่มีการ์ด
    child: ListView.builder(
      scrollDirection: Axis.horizontal, // ให้การ์ดเลื่อนได้ในแนวนอน
      itemCount: 10, // จำนวนการ์ด
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 300.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/product${index % 3 + 1}.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget buildheart() {
  return Container(
    height: 100.0, // กำหนดความสูงของ container ที่มีการ์ด
    child: ListView.builder(
      scrollDirection: Axis.horizontal, // ให้การ์ดเลื่อนได้ในแนวนอน
      itemCount: 10, // จำนวนการ์ด
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 100.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/product${index % 3 + 1}.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),
  );
}
