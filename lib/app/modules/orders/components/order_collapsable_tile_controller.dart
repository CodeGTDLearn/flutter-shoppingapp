import 'package:get/get.dart';

class OrderCollapsableTileController extends GetxController{

  var isTileCollapsed = false.obs;

  void toggleCollapseTile() {
    isTileCollapsed.value = !isTileCollapsed.value;
  }
}
