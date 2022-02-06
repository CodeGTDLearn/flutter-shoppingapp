import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../properties/properties.dart';
import 'i_core_snackbar.dart';

class CoreSnackbar implements ICoreSnackbar {
  int? durationMilis;

  CoreSnackbar([this.durationMilis]);

  void show(String title, String message) {
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