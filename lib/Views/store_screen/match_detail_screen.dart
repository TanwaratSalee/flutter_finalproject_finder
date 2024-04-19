import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finalproject/Views/store_screen/product_screen.dart';
import 'package:flutter_finalproject/Views/store_screen/store_screen.dart';
import 'package:flutter_finalproject/Views/widgets_common/our_button.dart';
import 'package:flutter_finalproject/consts/consts.dart';
import 'package:flutter_finalproject/controllers/product_controller.dart';
import 'package:get/get.dart';

class MatchDetailScreen extends StatefulWidget {
  final String productName1;
  final String productName2;
  final String price1;
  final String price2;
  final String productImage1;
  final String productImage2;
  final String totalPrice;

  const MatchDetailScreen({
    this.productName1 = '',
    this.productName2 = '',
    this.price1 = '',
    this.price2 = '',
    this.productImage1 = '',
    this.productImage2 = '',
    this.totalPrice = '',
  });

  @override
  _MatchDetailScreenState createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen> {
  bool isFavorited = false;
  late final ProductController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProductController());
    checkIsInWishlist();
  }

  void checkIsInWishlist() async {
    FirebaseFirestore.instance
        .collection(productsCollection)
        .where('p_name', whereIn: [widget.productName1, widget.productName2])
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            querySnapshot.docs.forEach((doc) {
              List<dynamic> wishlist = doc['p_wishlist'] ?? [];
              if (wishlist.contains(currentUser!.uid)) {
                controller.isFav(true);
              } else {
                controller.isFav(false);
              }
            });
          }
        });
  }

  void _updateIsFav(bool isFav) {
    setState(() {
      controller.isFav.value = isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Match Product',
          style: TextStyle(fontFamily: regular, fontSize: 32),
        ),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () => Get.back(),
        // ),
        elevation: 0,
        actions: <Widget>[
          Obx(
            () => IconButton(
              onPressed: () {
                setState(() {
                  List<String> productNames = [
                    widget.productName1,
                    widget.productName2
                  ];
                  bool isFav =
                      !controller.isFav.value; // Toggle the isFav value
                  productNames.forEach((productName) {
                    if (isFav == true) {
                      controller.addToWishlistMixMatch(
                          productName, _updateIsFav, context);
                    }
                    if (isFav == false) {
                      controller.removeToWishlistMixMatch(
                          productName, _updateIsFav, context);
                    }
                  });
                  print("isFav after toggling: $isFav"); // Debug print
                });
              },
              icon: Icon(
                controller.isFav.value
                    ? Icons.favorite
                    : Icons.favorite_outline,
                color: controller.isFav.value ? Colors.red : null,
              ),
              iconSize: 28,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 40, 8, 0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 230,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    'assets/images/product3.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: blackColor,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 1),
                              Text(
                                '5555 Bath',
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: blackColor,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: primaryApp,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: whiteColor,
                      size: 25,
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: 180,
                    height: 230,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    'assets/images/product4.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: blackColor,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 1),
                              Text(
                                '5555 Bath',
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: blackColor,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 229, 235, 237),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: whiteColor,
                              image: DecorationImage(
                                image: AssetImage('assets/icons/LogoOnApp.jpg'),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DIOR',
                      style: TextStyle(
                        fontFamily: regular,
                        color: blackColor,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      '⭐ 4.9/5',
                      style: TextStyle(
                        fontFamily: regular,
                        color: blackColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      // Get.to(() => StoreScreen());
                    },
                    child: Text(
                      'See Store',
                      style: TextStyle(
                        fontFamily: regular,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryApp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Opportunity suitable for',
                          style: TextStyle(
                            fontFamily: regular,
                            color: blackColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            for (String label in [
                              'Everyday',
                              'Dating',
                              'Seminars or meetings',
                            ])
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 229, 235, 237),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    label,
                                    style: TextStyle(
                                      color: primaryApp,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Text(
                      'The reason for this match',
                      style: TextStyle(
                        fontFamily: regular,
                        color: blackColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 229, 235, 237),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Choosing a simple shirt with a high-waisted mini or long skirt can create a comfortable but still stylish look.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: regular,
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
      // body: Padding(
      //   padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
      //   child: Column(
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Column(
      //             children: [
      //               Container(
      //                 width: 150,
      //                 height: 150,
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   border: Border.all(color: blackColor),
      //                 ),
      //                 child: Center(
      //                   child: Image.network(
      //                     widget.productImage1,
      //                     width: 120,
      //                     height: 120,
      //                     fit: BoxFit.cover,
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 height: 10,
      //               ),
      //               Text(widget.productName1,
      //                   style: const TextStyle(fontSize: 16, fontFamily: bold)),
      //               Text('฿${widget.price1}',
      //                   style:
      //                       const TextStyle(fontSize: 14, color: blackColor)),
      //             ],
      //           ),
      //           const SizedBox(width: 10), // สร้างระยะห่าง
      //           Stack(
      //             alignment: Alignment.center,
      //             children: [
      //               Container(
      //                 width: 20, // ขนาดของวงกลม
      //                 height: 20, // ขนาดของวงกลม
      //                 decoration: BoxDecoration(
      //                   color: Colors.lightBlue[100], // สีฟ้าอ่อน
      //                   shape: BoxShape.circle, // ทำให้เป็นรูปวงกลม
      //                 ),
      //               ),
      //               const Text('+',
      //                   style: TextStyle(
      //                       fontSize: 24,
      //                       fontFamily: bold,
      //                       color: Colors.white)),
      //             ],
      //           ),
      //           const SizedBox(width: 10),
      //           // สร้างระยะห่าง
      //           // สำหรับรูปภาพที่สองและข้อมูล
      //           Column(
      //             children: [
      //               Container(
      //                 width: 150,
      //                 height: 150,
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   border: Border.all(color: blackColor),
      //                 ),
      //                 child: Center(
      //                   child: Image.network(
      //                     widget.productImage2,
      //                     width: 120,
      //                     height: 120,
      //                     fit: BoxFit.cover,
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 height: 10,
      //               ),
      //               Text(widget.productName2,
      //                   style: const TextStyle(fontSize: 16, fontFamily: bold)),
      //               Text('฿${widget.price2}',
      //                   style:
      //                       const TextStyle(fontSize: 14, color: blackColor)),
      //             ],
      //           ),
      //         ],
      //       ),
      //       const SizedBox(height: 30), // เพิ่มระยะห่าง
      // Container(
      //   height: 65,
      //   margin: const EdgeInsets.only(
      //       bottom: 10), // ขยับ widget bar จากด้านบนลงมา
      //   child: Row(
      //     children: [
      //       Container(
      //         width: 70,
      //         height: 70,
      //         decoration: BoxDecoration(
      //           color: Colors.lightBlue[100],
      //           shape: BoxShape.circle,
      //         ),
      //         child: const Center(
      //           child: Text('Dior',
      //               style: TextStyle(fontSize: 14, color: Colors.white)),
      //         ),
      //       ),
      //       const SizedBox(width: 10),
      //       const Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text('Dior',
      //               style: TextStyle(fontSize: 16, fontFamily: bold)),
      //           Row(
      //             children: [
      //               Icon(Icons.star, color: Colors.yellow, size: 20),
      //               Icon(Icons.star, color: Colors.yellow, size: 20),
      //               Icon(Icons.star, color: Colors.yellow, size: 20),
      //               Icon(Icons.star, color: Colors.yellow, size: 20),
      //               Icon(Icons.star, color: Colors.yellow, size: 20),
      //             ],
      //           ),
      //         ],
      //       ),
      //       const Spacer(),
      //       ElevatedButton(
      //           onPressed: () {
      //             // ทำสิ่งที่ต้องการเมื่อกดปุ่ม
      //           },
      //           child: const Text('See Store'),
      //           style: ButtonStyle(
      //             backgroundColor:
      //                 MaterialStateProperty.all<Color>(Colors.white!),
      //             minimumSize:
      //                 MaterialStateProperty.all<Size>(const Size(0, 30)),
      //           )),
      //     ],
      //   ),
      //   decoration: BoxDecoration(
      //     color: Colors.grey[200],
      //     borderRadius: BorderRadius.circular(8),
      //   ),
      // ),
      // const SizedBox(height: 0.5),
      // เพิ่มระยะห่าง

      // const Padding(
      //   padding: EdgeInsets.fromLTRB(0, 0, 250, 0),
      //   child: Text(
      //     'Opportunity for',
      //     textAlign: TextAlign.left,
      //     style: TextStyle(
      //       fontSize: 12,
      //     ),
      //   ),
      // ),

      // Row(children: [
      //   ElevatedButton(
      //     onPressed: () {
      //       // ทำสิ่งที่ต้องการเมื่อกดปุ่ม
      //     },
      //     child: const Text(
      //       'Everyday',
      //       style: TextStyle(
      //         fontSize: 13,
      //       ),
      //     ),
      //     style: ButtonStyle(
      //       backgroundColor:
      //           MaterialStateProperty.all<Color>(Colors.grey[100]!),
      //       minimumSize:
      //           MaterialStateProperty.all<Size>(const Size(20, 20)),
      //       padding: MaterialStateProperty.all<EdgeInsets>(
      //         const EdgeInsets.symmetric(
      //             horizontal: 10, vertical: 5), // ปรับระยะห่างภายในปุ่ม
      //       ),
      //       textStyle: MaterialStateProperty.all<TextStyle>(
      //         const TextStyle(
      //           fontSize: 13, // ตั้งค่าขนาดตัวอักษรของข้อความภายในปุ่ม
      //         ),
      //       ),
      //     ),
      //   ),
      //   const SizedBox(width: 3),
      //   ElevatedButton(
      //     onPressed: () {
      //       // ทำสิ่งที่ต้องการเมื่อกดปุ่ม
      //     },
      //     child: const Text(
      //       'Dating',
      //       style: TextStyle(
      //         fontSize: 13,
      //       ),
      //     ),
      //     style: ButtonStyle(
      //       backgroundColor:
      //           MaterialStateProperty.all<Color>(Colors.grey[100]!),
      //       minimumSize:
      //           MaterialStateProperty.all<Size>(const Size(20, 20)),
      //       padding: MaterialStateProperty.all<EdgeInsets>(
      //         const EdgeInsets.symmetric(
      //             horizontal: 10, vertical: 5), // ปรับระยะห่างภายในปุ่ม
      //       ),
      //       textStyle: MaterialStateProperty.all<TextStyle>(
      //         const TextStyle(
      //           fontSize: 13, // ตั้งค่าขนาดตัวอักษรของข้อความภายในปุ่ม
      //         ),
      //       ),
      //     ),
      //   ),
      //   const SizedBox(width: 3),
      //   ElevatedButton(
      //     onPressed: () {
      //       // ทำสิ่งที่ต้องการเมื่อกดปุ่ม
      //     },
      //     child: const Text(
      //       'Seminars ',
      //       style: TextStyle(
      //         fontSize: 13,
      //       ),
      //     ),
      //     style: ButtonStyle(
      //       backgroundColor:
      //           MaterialStateProperty.all<Color>(Colors.grey[100]!),
      //       minimumSize:
      //           MaterialStateProperty.all<Size>(const Size(20, 20)),
      //       padding: MaterialStateProperty.all<EdgeInsets>(
      //         const EdgeInsets.symmetric(
      //             horizontal: 10, vertical: 5), // ปรับระยะห่างภายในปุ่ม
      //       ),
      //       textStyle: MaterialStateProperty.all<TextStyle>(
      //         const TextStyle(
      //           fontSize: 13, // ตั้งค่าขนาดตัวอักษรของข้อความภายในปุ่ม
      //         ),
      //       ),
      //     ),
      //   ),
      // ]),
      // const SizedBox(
      //   height: 10,
      //  ),
      // Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: Container(
      //     width: double.infinity, // ทำให้ container กว้างเต็มขอบ
      //     height: 150, // กำหนดความสูง
      //     decoration: BoxDecoration(
      //       color: Colors.grey[200], // ตั้งค่าสีพื้นหลัง
      //       borderRadius: BorderRadius.circular(10), // มุมโค้ง
      //     ),
      //     child: const Align(
      //       alignment: Alignment.topLeft, // จัดตำแหน่งข้อความชิดซ้ายบน
      //       child: Padding(
      //         padding: EdgeInsets.all(8.0), // เพิ่ม padding ให้ข้อความ
      //         child: Text(
      //           'HEllo ',
      //           style: TextStyle(
      //             color: blackColor,
      //             fontSize: 11,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // )
      // ],
      // ),
      // ),
 
