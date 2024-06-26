// ignore_for_file: unused_local_variable, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_finalproject/Views/news_screen/matchproduct_screen.dart';
import 'package:flutter_finalproject/Views/store_screen/item_details.dart';
import 'package:flutter_finalproject/Views/collection_screen/loading_indicator.dart';
import 'package:flutter_finalproject/Views/store_screen/match_detail_screen.dart';
import 'package:flutter_finalproject/Views/news_screen/product_screen.dart';
import 'package:flutter_finalproject/Views/store_screen/store_screen.dart';
import 'package:flutter_finalproject/Views/widgets_common/home_buttons.dart';
import 'package:flutter_finalproject/consts/consts.dart';
import 'package:flutter_finalproject/consts/lists.dart';
import 'package:flutter_finalproject/controllers/news_controller.dart';
import 'package:flutter_finalproject/services/firestore_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'dart:math' as math;

import '../widgets_common/appbar_ontop.dart';

class NewsScreen extends StatelessWidget {
  final String category;

  const NewsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allproducts = '';
    var controller = Get.find<NewsController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: appbarField(context: context),
        // actions: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15.0),
        //     child: IconButton(
        //       icon: Image.asset(
        //         icCart,
        //         width: 21,
        //       ),
        //       onPressed: () {
        //         Get.to(() => const CartScreen());
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        color: whiteColor,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
            child: Column(
          children: [
            // Container(
            //   alignment: Alignment.center,
            //   height: 60,
            //   color: whiteColor,
            //   child: TextFormField(
            //     controller: controller.searchController,
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       suffixIcon: const Icon(Icons.search).onTap(() {
            //         if (controller.searchController.text.isNotEmptyAndNotNull){
            //           Get.to(() => SearchScreen(
            //             title: controller.searchController.text,
            //         ));
            //         }
            //       }),
            //       filled: true,
            //       fillColor: fontGreyDark1,
            //       hintText: searchanything,
            //       // hintStyle: const TextStyle(color: fontGreyDark1),
            //     ),
            //   ),
            // ),

            // 1nd swiper
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 170,
                        enlargeCenterPage: true,
                        itemCount: sliderslist.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            sliderslist[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    10.heightBox,

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: List.generate(
                    //     2,
                    //     (index) => homeButtons(
                    //       height: context.screenHeight * 0.1,
                    //       width: context.screenWidth / 2.3,
                    //       icon: index == 0 ? icTodaysDeal : icFlashDeal,
                    //       title: index == 0 ? todayDeal : flashsale,
                    //     ),
                    //   ),
                    // ),

                    // 10.heightBox,

                    // 2nd swiper
                    // VxSwiper.builder(
                    //     aspectRatio: 16 / 9,
                    //     autoPlay: true,
                    //     height: 170,
                    //     enlargeCenterPage: true,
                    //     itemCount: secondSlidersList.length,
                    //     itemBuilder: (context, index) {
                    //       return Image.asset(
                    //         secondSlidersList[index],
                    //         fit: BoxFit.fill,
                    //       )
                    //           .box
                    //           .rounded
                    //           .clip(Clip.antiAlias)
                    //           .margin(const EdgeInsets.symmetric(horizontal: 8))
                    //           .make();
                    //     }),

                    10.heightBox,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButtons(
                          height: context.screenHeight * 0.1,
                          width: context.screenWidth / 3.5,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrand
                                  : icTopCategories,
                          title: index == 0
                              ? topCategories
                              : index == 1
                                  ? brand
                                  : topSellers,
                        ),
                      ),
                    ),

                    // 20.heightBox,
                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: featuredCategories.text
                    //         .color(blackColor)
                    //         .size(18)
                    //         .fontFamily(regular)
                    //         .make()),
                    // 20.heightBox,

                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: List.generate(
                    //         3,
                    //         (index) => Column(
                    //               children: [
                    //                 featuredButton(
                    //                     icon: featuredImages1[index],
                    //                     title: freaturedTitles1[index]),
                    //                 10.heightBox,
                    //                 featuredButton(
                    //                     icon: featuredImages2[index],
                    //                     title: freaturedTitles2[index]),
                    //               ],
                    //             )),
                    //   ),
                    // ),

                    // 20.heightBox,

                    // Container(
                    //   padding: const EdgeInsets.all(12),
                    //   width: double.infinity,
                    //   color: primaryApp,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       featuredProduct.text.white
                    //           .fontFamily(bold)
                    //           .size(18)
                    //           .make(),
                    //       10.heightBox,
                    //       SingleChildScrollView(
                    //         scrollDirection: Axis.horizontal,
                    //         child: FutureBuilder(
                    //           future: FirestoreServices.getFeaturedProducts(),
                    //           builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {

                    //             if(!snapshot.hasData) {
                    //               return Center(
                    //                 child: loadingIndcator(),
                    //               );
                    //             } else if (snapshot.data!.docs.isEmpty) {
                    //               return "No featured products".text.white.makeCentered();
                    //             } else {

                    //               var featuredData = snapshot.data!.docs;

                    //               return Row(
                    //               children: List.generate(
                    //                 featuredData.length,
                    //                 (index) => Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                       children: [
                    //                         Image.network(
                    //                           featuredData[index]['p_imgs'][0],
                    //                           width: 140,
                    //                           height: 195,
                    //                           fit: BoxFit.cover,
                    //                         ),
                    //                         10.heightBox,
                    //                         "${ featuredData[index]['p_name']}"
                    //                             .text
                    //                             .fontFamily(regular)
                    //                             .color(blackColor)
                    //                             .make(),
                    //                         5.heightBox,
                    //                         "${featuredData[index]['p_price']}"
                    //                             .numCurrency
                    //                             .text
                    //                             .color(primaryApp)
                    //                             .fontFamily(bold)
                    //                             .size(16)
                    //                             .make()
                    //                       ],
                    //                     )
                    //                         .box
                    //                         .white
                    //                         .margin(
                    //                             const EdgeInsets.symmetric(horizontal: 4))
                    //                         .rounded
                    //                         .padding(const EdgeInsets.all(8))
                    //                         .make()
                    //                         .onTap(() {
                    //                           Get.to(() => ItemDetails(title: "${featuredData[index]['p_name']}",
                    //                           data: featuredData[index],));
                    //                         })),
                    //               );
                    //             }
                    //           },
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    // 20.heightBox,

                    // 3nd swiper
                    // VxSwiper.builder(
                    //     aspectRatio: 16 / 9,
                    //     autoPlay: true,
                    //     height: 170,
                    //     enlargeCenterPage: true,
                    //     itemCount: secondSlidersList.length,
                    //     itemBuilder: (context, index) {
                    //       return Image.asset(
                    //         secondSlidersList[index],
                    //         fit: BoxFit.fill,
                    //       )
                    //           .box
                    //           .rounded
                    //           .clip(Clip.antiAlias)
                    //           .margin(const EdgeInsets.symmetric(horizontal: 8))
                    //           .make();
                    //     }),

                    // 20.heightBox,

                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: allproducts.text
                    //         .fontFamily(regular)
                    //         .color(redColor)
                    //         .size(18)
                    //         .make()),
                    30.heightBox,

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Ensure alignment if needed
                      children: [
                        'BRAND'
                            .text
                            .fontFamily(medium)
                            .color(greyDark2)
                            .size(22)
                            .make(),
                        Container(
                          child: GestureDetector(
                            child: Image.asset(
                              icUndertext,
                              width: 170,
                            ),
                          ),
                        ),
                      ],
                    )
                        .box
                        .color(thinPrimaryApp)
                        .padding(
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 70))
                        .roundedLg
                        .make(),

                    15.heightBox,
                    StreamBuilder(
                      stream: FirestoreServices.allmatchbystore(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          allproductsdata.shuffle(math.Random());

                          int itemCount = math.min(allproductsdata.length, 4);

                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: itemCount,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 100,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Image.network(
                                        allproductsdata[index]
                                            ['imageUrl'] /* s */,
                                        width: 200,
                                        height: 210,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${allproductsdata[index]['vendor_name']}",
                                          style: const TextStyle(
                                            fontFamily: medium,
                                            fontSize: 17,
                                            color: greyDark2,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow
                                              .ellipsis, // ใช้ ellipsis สำหรับข้อความที่เกิน
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                                  .box
                                  .white
                                  .rounded
                                  .shadowSm
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 2))
                                  .make()
                                  .onTap(() {
                                Get.to(
                                  () => StoreScreen(
                                      vendorId: allproductsdata[index]
                                          ['vendor_id']),
                                );
                              });
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: 50),

                     

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        'MATCH BY STORE'
                            .text
                            .fontFamily(medium)
                            .color(greyDark2)
                            .size(22)
                            .make(),
                        const SizedBox(height: 6),
                        Image.asset(
                          icUndertext,
                          width: 170,
                        ),
                        const SizedBox(height: 6),
                        SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.56,
                            child: _buildProductMathGrids(category),
                          ),
                        )
                      ],
                    ),

                    30.heightBox,

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Ensure alignment if needed
                      children: [
                        'PRODUCT'
                            .text
                            .fontFamily(medium)
                            .color(greyDark2)
                            .size(22)
                            .make(),
                        Container(
                          child: GestureDetector(
                            child: Image.asset(
                              icUndertext,
                              width: 170,
                            ),
                          ),
                        ),
                      ],
                    )
                        .box
                        .color(thinPrimaryApp)
                        .padding(
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 70))
                        .roundedLg
                        .make(),

                    const SizedBox(
                      height: 15,
                    ),

                    StreamBuilder(
                      stream: FirestoreServices.allproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          allproductsdata.shuffle(math.Random()); 

                          int itemCount = math.min(allproductsdata.length, 4);

                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: itemCount,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 280,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0),
                                        ),
                                        child: Image.network(
                                          allproductsdata[index]['p_imgs'][0],
                                          width: 200,
                                          height: 210,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${allproductsdata[index]['p_name']}",
                                          style: const TextStyle(
                                            fontFamily: medium,
                                            fontSize: 17,
                                            color: greyDark2,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow
                                              .ellipsis,
                                        ),
                                        Text(
                                          "${NumberFormat('#,##0').format(double.parse(allproductsdata[index]['p_price']).toInt())} Bath",
                                          style: const TextStyle(
                                            fontFamily: regular,
                                            fontSize: 14,
                                            color: greyDark2,
                                          ),
                                        ),
                                        const SizedBox(height: 10), 
                                      ],
                                    ),
                                  )
                                ],
                              )
                                  .box
                                  .white
                                  .rounded
                                  .shadowSm
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 2))
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
                    InkWell(
                      onTap: () {
                        Get.to(() => const ProductScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Explote More')
                              .text
                              .fontFamily(medium)
                              .size(17)
                              .color(greyDark2)
                              .make(),
                          10.widthBox,
                          Image.asset(
                            icNext,
                            width: 12,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildProductMathGrids(String category) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        Map<String, List<DocumentSnapshot>> mixMatchMap = {};

        for (var doc in snapshot.data!.docs) {
          var data = doc.data() as Map<String, dynamic>;
          if (data['p_mixmatch'] != null) {
            String mixMatchKey = data['p_mixmatch'];
            if (!mixMatchMap.containsKey(mixMatchKey)) {
              mixMatchMap[mixMatchKey] = [];
            }
            mixMatchMap[mixMatchKey]!.add(doc);
          }
        }

        var validPairs = mixMatchMap.entries
            .where((entry) => entry.value.length == 2)
            .toList();

        int itemCount = validPairs.length;
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            mainAxisExtent: 230,
          ),
          itemBuilder: (BuildContext context, int index) {
            var pair = validPairs[index].value;

            var data1 = pair[0].data() as Map<String, dynamic>;
            var data2 = pair[1].data() as Map<String, dynamic>;

            String price1 = data1['p_price'].toString();
            String price2 = data2['p_price'].toString();
            String totalPrice =
                (int.parse(price1) + int.parse(price2)).toString();

            String productName1 = data1['p_name'];
            String productName2 = data2['p_name'];

            String productImage1 = data1['p_imgs'][0];
            String productImage2 = data2['p_imgs'][0];

            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchDetailScreen(
                        price1: price1,
                        price2: price2,
                        productName1: productName1,
                        productName2: productName2,
                        productImage1: productImage1,
                        productImage2: productImage2,
                        totalPrice: totalPrice,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  productImage1,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productName1,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: greyDark2,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${NumberFormat('#,##0').format(double.parse(price1.toString()).toInt())} Bath",
                                        style:
                                            const TextStyle(color: greyDark1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  productImage2,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(19),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productName2,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: greyDark2,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${NumberFormat('#,##0').format(double.parse(price2.toString()).toInt())} Bath",
                                        style:
                                            const TextStyle(color: greyDark1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                                    children: [
                                      Text(
                                        "Total Price ",
                                        style: TextStyle(
                                          color:
                                              greyDark2, 
                                          fontFamily:
                                              'regular', 
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "${NumberFormat('#,##0').format(double.parse(totalPrice.toString()).toInt())} ",
                                        style: TextStyle(
                                          color:
                                              greyDark2, 
                                          fontFamily:
                                              'medium', 
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Bath",
                                        style: TextStyle(
                                          color:
                                              greyDark2, 
                                          fontFamily:
                                              'regular', 
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                        ],
                      )
                          .box
                          .color(whiteColor)
                          .padding(const EdgeInsets.all(12))
                          .rounded
                          .shadowSm
                          .make(),
                    ),
                  ],
                ));
          },
          itemCount: 2,
        );
      },
    );
  }
}

class GridCardExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)), // ขอบมนของการ์ด
        );
      },
    );
  }
}

class ButtonsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              print("Button $index pressed");
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
              foregroundColor: MaterialStateProperty.all<Color>(greyDark2),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
            ),
            child: Text("Button ${index + 1}"),
          ),
        );
      }),
    );
  }
}
