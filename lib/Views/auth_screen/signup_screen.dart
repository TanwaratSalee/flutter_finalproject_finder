// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_finalproject/Views/auth_screen/personal_details_screen.dart';
import 'package:flutter_finalproject/Views/auth_screen/verifyemail_screen.dart';
import 'package:flutter_finalproject/Views/widgets_common/custom_textfield.dart';
import 'package:flutter_finalproject/Views/widgets_common/our_button.dart';
import 'package:flutter_finalproject/consts/colors.dart';
import 'package:flutter_finalproject/consts/consts.dart';
import 'package:flutter_finalproject/consts/strings.dart';
import 'package:get/get.dart';

import '../../consts/styles.dart';
import '../../controllers/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var controller = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRetypeController =
      TextEditingController();

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return "";
    return text[0].toUpperCase() + text.substring(1);
  }

  bool validateInput() {
    if (emailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordController.text == passwordRetypeController.text &&
        passwordController.text[0] ==
            passwordController.text[0].toUpperCase() &&
        passwordController.text.length >= 8 &&
        !passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return true;
    } else {
      // Show VxToast and highlight red border for invalid fields
      VxToast.show(
        context,
        msg: 'Check your password!',
        // bgColor: Colors.red,
      );
      return false;
    }
  }

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          title: const Text('Create Account')
              .text
              .size(24)
              .fontFamily(medium)
              .make()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            customTextField(
              label: capitalizeFirstLetter(fullname),
              controller: nameController,
              isPass: false,
              readOnly: false,
            ),
            const SizedBox(height: 3),
            customTextField(
              label: email,
              controller: emailController,
              isPass: false,
              readOnly: false,
            ),
            const SizedBox(height: 3),
            customTextField(
              label: password,
              controller: passwordController,
              isPass: true,
              readOnly: false,
              borderColor: passwordController.text.isNotEmpty &&
                      (passwordController.text[0] !=
                              passwordController.text[0].toUpperCase() ||
                          passwordController.text.length < 8 ||
                          passwordController.text
                              .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')))
                  ? Colors.red
                  : null,
            ),
            const SizedBox(height: 3),
            customTextField(
              label: confirmPassword,
              controller: passwordRetypeController,
              isPass: true,
              readOnly: false,
              borderColor: passwordRetypeController.text.isNotEmpty &&
                      passwordRetypeController.text != passwordController.text
                  ? Colors.red
                  : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Checkbox(
                    activeColor: primaryApp,
                    checkColor: whiteColor,
                    value: isCheck,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isCheck = newValue ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: RichText(
                        text: const TextSpan(children: [
                  TextSpan(
                      text: "I agree to the ",
                      style: TextStyle(color: greyDark2, fontFamily: bold)),
                  TextSpan(
                      text: termAndCond,
                      style: TextStyle(color: primaryApp, fontFamily: bold)),
                  TextSpan(
                      text: " & ",
                      style: TextStyle(
                        color: greyDark2,
                        fontFamily: bold,
                      )),
                  TextSpan(
                      text: privacyPolicy,
                      style: TextStyle(
                        color: primaryApp,
                        fontFamily: bold,
                      ))
                ])))
              ],
            ),
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(primaryApp),
                  )
                : ourButton(
                    color: isCheck == true ? primaryApp : greyDark1,
                    title: 'Next',
                    textColor: whiteColor,
                    onPress: isCheck
                        ? () {
                            // Validate input before changing the screen
                            if (validateInput()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PersonalDetailsScreen(
                                    email: emailController.text,
                                    name: nameController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              );
                            }
                          }
                        : null,
                  ),
          ],
        ),
      ),
    );
  }
}
