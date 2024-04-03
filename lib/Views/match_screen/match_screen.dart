import 'package:flutter/material.dart';
import 'package:flutter_finalproject/Views/search_screen/search_screen.dart';
import 'package:flutter_finalproject/consts/colors.dart';
import 'package:flutter_finalproject/consts/images.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../cart_screen/cart_screen.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  int selectedCardIndex = 0; // เก็บ index ของการ์ดที่ถูกเลือก
  double initialX = 0.0;
  double updatedX = 0.0;
  bool isFirstCardActive =
      true; // ตัวแปรเพื่อตรวจสอบว่าชุดการ์ดที่หนึ่งเปิดใช้งานหรือไม่

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: Image.asset(
              icSearch,
              width: 23,
            ),
            onPressed: () {
              // Logic for search icon button
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
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50), // เว้นระยะห่างจาก AppBar
            // ชุดการ์ดที่ 1
            GestureDetector(
              // GestureDetector configuration here...
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(10, (index) {
                  return Card(
                    elevation:
                        selectedCardIndex == index && isFirstCardActive ? 5 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 300.0,
                      height: 230.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/product${index % 3 + 1}.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
                height:
                    20), // เว้นระยะห่างระหว่างชุดการ์ดที่ 1 และชุดการ์ดที่ 2
            // ชุดการ์ดที่ 2
            GestureDetector(
              // GestureDetector configuration here...
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(10, (index) {
                  return Card(
                    elevation: selectedCardIndex == index && !isFirstCardActive
                        ? 5
                        : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 300.0,
                      height: 230.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/product${index % 3 + 1}.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
