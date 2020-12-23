import 'package:get/get.dart';

class GlobalMethods {
  static void tearDown() {
    // print("tearDown global");
    Get.reset();
  }
}
