import 'package:get/instance_manager.dart';

import '../../../modules/cart/core/cart_bindings.dart';
import '../../../modules/inventory/core/inventory_bindings.dart';
import '../../../modules/orders/core/orders_bindings.dart';
import '../components_icons.dart';
import 'custom_drawer.dart';

class CustomDrawerBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => ComponentsIcons());
    Get.lazyPut(() => CustomDrawer());
    CartBindings().dependencies();
    OrdersBindings().dependencies();
    InventoryBindings().dependencies();
  }
}