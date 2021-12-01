import 'package:get/instance_manager.dart';

import '../../modules/cart/core/cart_bindings.dart';
import '../../modules/inventory/core/inventory_bindings.dart';
import '../../modules/orders/core/orders_bindings.dart';

class DrawerBindings extends Bindings {
  void dependencies() {
    CartBindings().dependencies();
    OrdersBindings().dependencies();
    InventoryBindings().dependencies();
  }
}