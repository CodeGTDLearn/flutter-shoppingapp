import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../properties/app_properties.dart';
import 'abstract_custom_snackbar.dart';

class SimpleSnackbar implements AbstractCustomSnackbar {
  String title;
  String message;
  int? durationMilis;

  SimpleSnackbar(this.title, this.message, [this.durationMilis]);

  void show() {
    Get.snackbar(
      title,
      message,
      duration: Duration(milliseconds: durationMilis ??= DURATION),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }
}
