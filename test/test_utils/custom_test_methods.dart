import 'package:get/get.dart';

class CustomTestMethods {
  static void globalTearDown() {
    Get.reset();
  }
}
