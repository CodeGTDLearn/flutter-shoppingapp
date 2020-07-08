import 'package:get/get.dart';

import '../modules/orders/components/order_collapse_tile_controller.dart';
import '../modules/orders/orders_controller.dart';
import '../modules/orders/repo/i_orders_repo.dart';
import '../modules/orders/repo/orders_firebase_repo.dart';
import '../modules/orders/service/i_orders_service.dart';
import '../modules/orders/service/orders_service.dart';

class CoreBinding implements Bindings {
  @override
  void dependencies() {

    //ORDER MODULE:
    Get.lazyPut<IOrdersService>(() => OrdersService());
    Get.lazyPut<IOrdersRepo>(() => OrdersFirebaseRepo());
    Get.lazyPut<OrdersController>(() => OrdersController());
//    GetInstance().create(()=> OrderCollapseTileController());
  }
}