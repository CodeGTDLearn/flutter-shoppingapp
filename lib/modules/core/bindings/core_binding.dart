import 'package:get/get.dart';

import 'cart.dart';
import 'managed_products.dart';
import 'orders.dart';
import 'overview.dart';

class CoreBinding extends Bindings {
  void dependencies() {
    Cart.dependencies();
    Orders.dependencies();
    Overview.dependencies();
    ManagedProducts.dependencies();
  }
}
