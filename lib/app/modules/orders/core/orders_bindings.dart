import 'package:get/get.dart';

import '../controller/orders_controller.dart';
import '../repo/i_orders_repo.dart';
import '../repo/orders_repo_firebase.dart';
import '../service/i_orders_service.dart';
import '../service/orders_service.dart';

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
