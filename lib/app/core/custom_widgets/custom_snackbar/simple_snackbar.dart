import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/route_manager.dart';

import '../../properties/app_properties.dart';
import 'icustom_snackbar.dart';

class SimpleSnackbar implements ICustomSnackbar {
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