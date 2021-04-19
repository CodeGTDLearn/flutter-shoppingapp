import 'package:get/get.dart';

import '../../components/drawwer.dart';
import '../../overview/service/i_overview_service.dart';
import '../controller/inventory_controller.dart';
import '../repo/i_inventory_repo.dart';
import '../repo/inventory_repo_http.dart';
import '../service/i_inventory_service.dart';
import '../service/inventory_service.dart';

class InventoryBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<Drawwer>(() => Drawwer());

    Get.lazyPut<IInventoryRepo>(() => InventoryRepoHttp());

    Get.lazyPut<IInventoryService>(() => InventoryService(
          repo: Get.find<IInventoryRepo>(),
          overviewService: Get.find<IOverviewService>(),
        ));

    Get.lazyPut<InventoryController>(() => InventoryController(
          service: Get.find<IInventoryService>(),
        ));
  }
}
