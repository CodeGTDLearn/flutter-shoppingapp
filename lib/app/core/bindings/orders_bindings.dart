import 'package:get/get.dart';

import '../../modules/orders/controller/orders_controller.dart';
import '../../modules/orders/repo/i_orders_repo.dart';
import '../../modules/orders/repo/orders_repo_firebase.dart';
import '../../modules/orders/service/i_orders_service.dart';
import '../../modules/orders/service/orders_service.dart';

class OrdersBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<IOrdersRepo>(() => OrdersRepoFirebase());

    Get.lazyPut<IOrdersService>(() => OrdersService(
          repo: Get.find<IOrdersRepo>(),
        ));

    Get.lazyPut<OrdersController>(() => OrdersController(
          service: Get.find<IOrdersService>(),
        ));
  }
}