import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class AppGlobalTestMethods {
  static void tearDown() {
    print("teaDown global");
    Get.reset();
  }
}
