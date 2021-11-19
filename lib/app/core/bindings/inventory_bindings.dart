import 'package:get/get.dart';

import '../../modules/inventory/controller/inventory_controller.dart';
import '../../modules/inventory/repo/i_inventory_repo.dart';
import '../../modules/inventory/repo/inventory_repo_firebase.dart';
import '../../modules/inventory/service/i_inventory_service.dart';
import '../../modules/inventory/service/inventory_service.dart';
import '../../modules/overview/service/i_overview_service.dart';
import '../components/custom_drawer.dart';

class InventoryBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<CustomDrawer>(() => CustomDrawer());

    Get.lazyPut<IInventoryRepo>(() => InventoryRepoFirebase());

    Get.lazyPut<IInventoryService>(() => InventoryService(
          repo: Get.find<IInventoryRepo>(),
          overviewService: Get.find<IOverviewService>(),
        ));

    Get.lazyPut<InventoryController>(() => InventoryController(
          service: Get.find<IInventoryService>(),
        ));
  }
}