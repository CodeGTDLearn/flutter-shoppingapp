import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static simple(String title, message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.black,
      duration: Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM
    );
  }
}
