import 'package:get/instance_manager.dart';

import '../../../modules/cart/core/cart_bindings.dart';
import '../../../modules/inventory/core/inventory_bindings.dart';
import '../../../modules/orders/core/orders_bindings.dart';
import '../core_components_icons.dart';
import 'core_drawer.dart';

class CoreDrawerBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => CoreComponentsIcons());
    Get.lazyPut(() => CoreDrawer());
    CartBindings().dependencies();
    OrdersBindings().dependencies();
    InventoryBindings().dependencies();
  }
}