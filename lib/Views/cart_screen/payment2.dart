import 'package:flutter/material.dart';
import 'package:flutter_finalproject/Views/cart_screen/address_screen.dart';
import 'package:flutter_finalproject/Views/cart_screen/visa_screen.dart';
import 'package:flutter_finalproject/consts/consts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
// Import หน้า VisaCardScreen ที่ต้องการนำไป

void main() {
  runApp(MaterialApp(home: PaymentMethods()));
}

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  State<PaymentMethods> createState() => _AllofthingScreenState();
}

class _AllofthingScreenState extends State<PaymentMethods> {
  bool isExpandedList = false;
  List<String> imageUrls = [
    'assets/images/payment/Kbank.png',
    'assets/images/payment/SCE.png',
    'assets/images/payment/BBL.png',
    'assets/images/payment/krungthai.png',
    'assets/images/payment/KMA.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Allofthing',
          style: TextStyle(fontFamily: 'regular', color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 50, 8, 0),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildBox('Delivery', MdiIcons.truckDeliveryOutline),
                    SizedBox(height: 10),
                    _buildBoxWithPopup(
                      'Mobile Banking',
                      MdiIcons.cellphone,
                      isExpandedList,
                      () {
                        setState(() {
                          isExpandedList = !isExpandedList;
                        });
                      },
                    ),
                    if (isExpandedList) ...[
                      SizedBox(
                        height: 285,
                        child: _buildExpandedList(),
                      ),
                    ],
                    SizedBox(height: 10),
                    _buildBox('Credit Card', MdiIcons.creditCardOutline),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(String title, IconData iconData) {
    return GestureDetector(
      onTap: () {
        if (title == 'Delivery') {
          Get.to(() => AddressScreen());
        } else if (title == 'Credit Card') {
          Get.to(() => const VisaCardScreen());
        } else {
          print('Tap on $title');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Icon(iconData, size: 30),
          title: Text(title),
        ),
      ),
    );
  }

  Widget _buildBoxWithPopup(
      String title, IconData iconData, bool isExpandedList, Function onTap) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Icon(iconData, size: 30),
          title: Text(title),
          trailing: Icon(
            isExpandedList ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedList() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: greyColor),
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return Column(
                children: [
                  ListTile(
                    title: Text('K PLUS'),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(imageUrls[index]),
                    ),
                    onTap: () {
                      print('Tapped on Custom Option 1');
                    },
                  ),
                  Divider(
                    color: greyColor,
                    thickness: 1,
                    height: 0,
                  ),
                ],
              );
            case 1:
              return Column(
                children: [
                  ListTile(
                    title: Text('SCB'),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(imageUrls[index]),
                    ),
                    onTap: () {
                      print('Tapped on Custom Option 2');
                    },
                  ),
                  Divider(
                    color: greyColor,
                    thickness: 1,
                    height: 0,
                  ),
                ],
              );
            case 2:
              return Column(
                children: [
                  ListTile(
                    title: Text('BBL'),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                        imageUrls[index],
                      ),
                    ),
                    onTap: () {
                      print('Tapped on Custom Option 3');
                    },
                  ),
                  Divider(
                    color: greyColor,
                    thickness: 1,
                    height: 0,
                  ),
                ],
              );
            case 3:
              return Column(
                children: [
                  ListTile(
                    title: Text('KTB'),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(imageUrls[index]),
                    ),
                    onTap: () {
                      print('Tapped on Custom Option 4');
                    },
                  ),
                  Divider(
                    color: greyColor,
                    thickness: 1,
                    height: 0,
                  ),
                ],
              );
            case 4:
              return Column(
                children: [
                  ListTile(
                    title: Text('KMA'),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(imageUrls[index]),
                    ),
                    onTap: () {
                      print('Tapped on Custom Option 5');
                    },
                  ),
                  Divider(
                    color: greyColor,
                    thickness: 1,
                    height: 0,
                  ),
                ],
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
