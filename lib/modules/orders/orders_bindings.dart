import 'package:get/get.dart';

import 'orders_controller.dart';
import 'repo/i_orders_repo.dart';
import 'repo/orders_firebase_repo.dart';
import 'service/i_orders_service.dart';
import 'service/orders_service.dart';

class OrdersBindings  extends Bindings{
  void dependencies() {
    Get.lazyPut<IOrdersService>(() => OrdersService());
    Get.lazyPut<IOrdersRepo>(() => OrdersFirebaseRepo());
    Get.lazyPut<OrdersController>(() => OrdersController());
  }
}
