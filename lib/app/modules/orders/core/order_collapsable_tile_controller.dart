import 'package:get/state_manager.dart';

class OrderCollapsableTileController extends GetxController {
  var isTileCollapsed = false.obs;

  void toggleCollapseTile() {
    isTileCollapsed.value = !isTileCollapsed.value;
  }
}