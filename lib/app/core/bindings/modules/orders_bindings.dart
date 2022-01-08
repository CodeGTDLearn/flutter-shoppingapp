import 'package:get/instance_manager.dart';

import '../../../modules/orders/components/custom_tiles/expandable_tile.dart';
import '../../../modules/orders/components/custom_tiles/icustom_order_tile.dart';
import '../../../modules/orders/controller/orders_controller.dart';
import '../../../modules/orders/repo/i_orders_repo.dart';
import '../../../modules/orders/repo/orders_repo_http.dart';
import '../../../modules/orders/service/i_orders_service.dart';
import '../../../modules/orders/service/orders_service.dart';
import '../../labels/modules/orders_labels.dart';
import '../global_widgets/appbars_bindings.dart';

class OrdersBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => OrdersLabels());
    AppbarsBindings().dependencies();
    Get.lazyPut<ICustomOrderTile>(() => ExpandableTile());

    Get.lazyPut<IOrdersRepo>(() => OrdersRepoHttp());
    Get.lazyPut<IOrdersService>(() => OrdersService(repo: Get.find<IOrdersRepo>()));
    Get.lazyPut(() => OrdersController(service: Get.find<IOrdersService>()));
  }
}