import 'package:get/instance_manager.dart';

import '../../../core/global_bindings/custom_appbars_binding.dart';
import '../controller/orders_controller.dart';
import '../repo/i_orders_repo.dart';
import '../repo/orders_repo_http.dart';
import '../service/i_orders_service.dart';
import '../service/orders_service.dart';
import 'custom_tiles/expandable_tile.dart';
import 'custom_tiles/icustom_order_tile.dart';

class OrdersBindings extends Bindings {
  void dependencies() {

    CustomAppbarsBinding().dependencies();
    Get.lazyPut<ICustomOrderTile>(() => ExpandableTile());

    Get.lazyPut<IOrdersRepo>(() => OrdersRepoHttp());
    Get.lazyPut<IOrdersService>(() => OrdersService(repo: Get.find<IOrdersRepo>()));
    Get.lazyPut<OrdersController>(() => OrdersController(
          service: Get.find<IOrdersService>()
        ));
  }
}