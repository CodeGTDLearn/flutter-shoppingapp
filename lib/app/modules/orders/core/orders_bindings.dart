import 'package:get/instance_manager.dart';

import '../controller/orders_controller.dart';
import '../repo/i_orders_repo.dart';
import '../repo/orders_repo_http_firebase.dart';
import '../service/i_orders_service.dart';
import '../service/orders_service.dart';
import 'components/custom_tiles/expandable_tile.dart';
import 'components/custom_tiles/icustom_order_tile.dart';
import 'orders_labels.dart';

class OrdersBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => OrdersLabels());
    // CoreAppbarsBindings().dependencies();
    Get.lazyPut<ICustomOrderTile>(() => ExpandableTile());

    Get.lazyPut<IOrdersRepo>(() => OrdersRepoHttpFirebase());
    Get.lazyPut<IOrdersService>(() => OrdersService(repo: Get.find<IOrdersRepo>()));
    Get.lazyPut(() => OrdersController(service: Get.find<IOrdersService>()));
  }
}