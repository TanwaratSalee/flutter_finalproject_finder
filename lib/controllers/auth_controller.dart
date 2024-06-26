import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_finalproject/Views/auth_screen/login_screen.dart';
import 'package:flutter_finalproject/Views/auth_screen/verifyemail_screen.dart';
import 'package:flutter_finalproject/consts/consts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Views/home_screen/mainHome.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
  DateTime selectedDate = DateTime.now();
  String? selectedSex;
  Color? selectedSkinTone;
  bool canSelectSkin = true;

  //textcontrollers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var heightController = TextEditingController();
  var weightController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      print("Login successful: $userCredential");
    } on FirebaseAuthException catch (e) {
      print("Login failed: $e");
      VxToast.show(context, msg: e.toString());
    }

    return userCredential;
  }

  //signup method

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  bool validateUserData() {
    if (selectedDate == null ||
        selectedSex == null ||
        selectedSkinTone == null) {
      return false;
    }
    if (heightController.text.isEmpty || weightController.text.isEmpty) {
      return false;
    }
    return true;
  }

  // storeUserData({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String birthday,
  //   required String sex,
  //   required String uHeight,
  //   required String uWeigh,
  //   required String skin,
  // }) async {
  //   print("กำลังเก็บเพศเป็น: $sex");
  //   try {
  //     DocumentReference store =
  //         firestore.collection(usersCollection).doc(currentUser!.uid);
  //     await store.set({
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //       'imageUrl': '',
  //       'birthday': birthday,
  //       'sex': sex,
  //       'height': height,
  //       'weight': weight,
  //       'skin': skin,
  //       'id': currentUser?.uid,
  //       'cart_count': "0",
  //       'wishlist_count': "0",
  //       'order_count': "0"
  //     });
  //   } catch (e) {
  //     // Handle errors here, e.g., unable to store data
  //   }
  // }

  Future<void> saveUserData({
    required String name,
    required String email,
    required String password,
    required DateTime birthday,
    required String gender,
    required String uHeight,
    required String uWeight,
    required Color skin,
  }) async {
    isloading(true);
    try {
      final UserCredential currentUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // จัดรูปแบบวันที่เพื่อรวมชื่อวันในสัปดาห์
      String formattedDateWithDay =
          DateFormat('EEEE, dd/MM/yyyy').format(birthday);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.user!.uid)
          .set({
        'email': email,
        'name': name,
        // 'password': password,
        'imageUrl': '',
        'id': currentUser.user!.uid,
        'birthday': formattedDateWithDay,
        'gender': gender,
        'height': uHeight,
        'weight': uWeight,
        'skinTone': skin.value,
        'cart_count': "0",
        'wishlist_count': "0",
        'order_count': "0"
      });

      // แสดงข้อความเมื่อบันทึกข้อมูลสำเร็จ
      Get.snackbar('Success', 'User data saved successfully!');

      // ปรับเปลี่ยนไปใช้ VerifyEmailScreen ก่อนไป MainHome
      // สำคัญ: ต้องรับ context มาในพารามิเตอร์ของฟังก์ชัน saveUserData หรือใช้ Get.context ถ้าคุณไม่อยากเพิ่ม context เป็นพารามิเตอร์
      Get.offAll(() => VerifyEmailScreen(
        email: email,
        name: name,
        password: password,
      ));
    } catch (e) {
      print("Failed to upload user data: $e");
      Get.snackbar('Error', 'Failed to upload user data: $e');
    } finally {
      isloading(false);
    }
  }

  Future<void> saveUserDataGoogle({
    required UserCredential currentUser,
    required String name,
    required DateTime birthday,
    required String gender,
    required String uHeight,
    required String uWeight,
    required Color skin,
  }) async {
    try {
      String formattedDateWithDay =
          DateFormat('EEEE, dd/MM/yyyy').format(birthday);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.user!.uid)
          .set({
        'email': currentUser.user!.email, // ใช้ email จาก currentUser
        'name': name,
        'imageUrl': currentUser.user!.photoURL ??
            '', // ใช้ URL รูปภาพจาก currentUser (ถ้ามี)
        'id': currentUser.user!.uid,
        'birthday': formattedDateWithDay,
        'gender': gender,
        'height': uHeight,
        'weight': uWeight,
        'skinTone': skin.value,
        'cart_count': "0",
        'wishlist_count': "0",
        'order_count': "0"
      });

      Get.snackbar('Success', 'User data saved successfully!');
      Get.offAll(() => MainHome());
    } catch (e) {
      print("Failed to upload user data: $e");
      Get.snackbar('Error', 'Failed to upload user data: $e');
    }
  }

  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email has been sent.')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    }
  }

  //Signout method
  signoutMethod(context) async {
    print('Starting to logout...');
    try {
      await FirebaseAuth.instance.signOut();
      print('Firebase sign out success');
      Get.offAll(() => const LoginScreen());
      print('Navigated to LoginScreen');
    } catch (e) {
      print('Logout error: $e');
    }
  }
}
