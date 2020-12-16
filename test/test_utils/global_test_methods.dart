import 'package:get/get.dart';

class GlobalTestMethods {
  static void tearDown() {
    print("tearDown global");
    Get.reset();
  }
}
