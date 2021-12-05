import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/custom_widgets/custom_drawer.dart';

import '../../modules/cart/core/cart_bindings.dart';
import '../../modules/inventory/core/inventory_bindings.dart';
import '../../modules/orders/core/orders_bindings.dart';

class CustomDrawerBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<CustomDrawer>(() => CustomDrawer());
    CartBindings().dependencies();
    OrdersBindings().dependencies();
    InventoryBindings().dependencies();
  }
}