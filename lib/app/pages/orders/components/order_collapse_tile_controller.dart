import 'package:get/get.dart';

class OrderCollapseTileController extends GetxController{

  var isTileCollapsed = false.obs;

  void toggleCollapseTile() {
    isTileCollapsed.value = !isTileCollapsed.value;
  }
}
