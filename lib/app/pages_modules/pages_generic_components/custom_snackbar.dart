import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/properties/app_properties.dart';

class CustomSnackBar {
  static simple(String title, message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.black,
      duration: Duration(milliseconds: INTERVAL),
      snackPosition: SnackPosition.BOTTOM
    );
  }
}
