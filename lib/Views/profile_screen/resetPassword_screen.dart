import 'package:flutter/material.dart';
import 'package:flutter_finalproject/Views/widgets_common/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:flutter_finalproject/controllers/profile_controller.dart';
import 'package:flutter_finalproject/consts/consts.dart'; // Ensure this file exists and contains your constants

class PasswordScreen extends StatelessWidget {
  final oldpassController = TextEditingController();
  final newpassController = TextEditingController();
  final confirmNewPassController =
      TextEditingController(); // ตัวควบคุมสำหรับการยืนยันรหัสผ่านใหม่

  PasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: whiteColor, // Ensure this constant is defined
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Reset Password",
            style: TextStyle(
                fontFamily: medium, fontSize: 24, color: blackColor)),
        actions: [
          Obx(() {
            if (controller.isloading.isTrue) {
              return const CircularProgressIndicator().p16();
            }
            return TextButton(
              onPressed: () async {
                // ตรวจสอบว่า New Password กับ Confirm New Password ตรงกันหรือไม่
                if (newpassController.text == confirmNewPassController.text) {
                  controller.isloading(true);

                  final result = await controller.changeAuthPassword(
                    oldPassword: oldpassController.text,
                    newPassword: newpassController.text,
                  );

                  if (result) {
                    VxToast.show(context, msg: "Password updated successfully");
                  } else {
                    VxToast.show(context, msg: "Failed to update password");
                  }

                  controller.isloading(false);
                } else {
                  // แสดงข้อความแจ้งเตือนหากรหัสผ่านใหม่และการยืนยันไม่ตรงกัน
                  VxToast.show(context,
                      msg: "New password and confirmation do not match");
                }
              },
              child: "Save".text.color(Colors.blue).make(),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Column(
            children: [
              customTextField(
                label: "Old Password",
                controller: oldpassController,
                isPass: true,
                readOnly: false,
              ).p2(),
              const SizedBox(height: 15),
              customTextField(
                label: "New Password",
                controller: newpassController,
                isPass: true,
                readOnly: false,
              ).p2(),
              customTextField(
                label:
                    "Confirm New Password", // เพิ่ม TextField สำหรับการยืนยันรหัสผ่านใหม่
                controller: confirmNewPassController,
                isPass: true,
                readOnly: false,
              ).p2(),
            ],
          ),
        ),
      ),
    );
  }
}
