import 'package:get/instance_manager.dart';

import '../../global_widgets/custom_drawer.dart';
import '../../icons/global_widgets_icons.dart';
import '../modules/cart_bindings.dart';
import '../modules/inventory_bindings.dart';
import '../modules/orders_bindings.dart';

class CustomDrawerBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => GlobalWidgetsIcons());
    Get.lazyPut(() => CustomDrawer());
    CartBindings().dependencies();
    OrdersBindings().dependencies();
    InventoryBindings().dependencies();
  }
}