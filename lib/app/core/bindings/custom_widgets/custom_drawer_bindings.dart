import 'package:get/instance_manager.dart';

import '../../custom_widgets/custom_drawer.dart';
import '../modules/cart_bindings.dart';
import '../modules/inventory_bindings.dart';
import '../modules/orders_bindings.dart';

class CustomDrawerBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<CustomDrawer>(() => CustomDrawer());
    CartBindings().dependencies();
    OrdersBindings().dependencies();
    InventoryBindings().dependencies();
  }
}