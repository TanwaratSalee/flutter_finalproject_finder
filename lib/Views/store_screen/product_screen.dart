import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_finalproject/Views/cart_screen/cart_screen.dart';
import 'package:flutter_finalproject/Views/store_screen/item_details.dart';
import 'package:flutter_finalproject/Views/collection_screen/loading_indicator.dart';
import 'package:flutter_finalproject/Views/widgets_common/appbar_ontop.dart';
import 'package:flutter_finalproject/Views/widgets_common/search_icon.dart';
import 'package:flutter_finalproject/consts/consts.dart';
import 'package:flutter_finalproject/controllers/news_controller.dart';
import 'package:flutter_finalproject/services/firestore_services.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

import 'package:intl/intl.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var controller = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Image.asset(icLogoOnTop, height: 40),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        color: whiteColor,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 680,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: const Text(
                      //     'All Products',
                      //     style: TextStyle(
                      //       fontFamily: regular,
                      //       color: greyDark2,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
                      StreamBuilder(
                        stream: FirestoreServices.allproducts(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot,
                        ) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else {
                            var allproductsdata = snapshot.data!.docs;
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 18,
                                crossAxisSpacing: 12,
                                mainAxisExtent: 280,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      allproductsdata[index]['p_imgs'][0],
                                      width: 210,
                                      height: 210,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${allproductsdata[index]['p_name']}",
                                            style: const TextStyle(
                                              fontFamily: medium,
                                              fontSize: 17,
                                              color: blackColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "${NumberFormat('#,##0').format(double.parse(allproductsdata[index]['p_price']).toInt())} Bath",
                                            style: const TextStyle(
                                              color: greyDark1,
                                              fontFamily: regular,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 2))
                                    .shadowSm
                                    .rounded
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                        title:
                                            "${allproductsdata[index]['p_name']}",
                                        data: allproductsdata[index],
                                      ));
                                });
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
