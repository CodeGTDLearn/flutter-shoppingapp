import 'package:get/get.dart';

import '../../orders/orders_controller.dart';
import '../../orders/repo/i_orders_repo.dart';
import '../../orders/repo/orders_firebase_repo.dart';
import '../../orders/service/i_orders_service.dart';
import '../../orders/service/orders_service.dart';

class Orders {
  static void dependencies() {
    Get.lazyPut<IOrdersService>(() => OrdersService());
    Get.lazyPut<IOrdersRepo>(() => OrdersFirebaseRepo());
    Get.lazyPut<OrdersController>(() => OrdersController());
    //GetInstance().create(() => OrderCollapseTileController());
  }
}
