import 'package:get/get.dart';

class CustomTestMethods {
  static void globalTearDown() {
    // print("tearDown global");
    Get.reset();
  }
}
