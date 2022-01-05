import 'package:get/instance_manager.dart';

import '../../../modules/inventory/components/custom_listview/icustom_inventory_listview.dart';
import '../../../modules/inventory/components/custom_listview/staggered_sliver_listview.dart';
import '../../../modules/inventory/controller/inventory_controller.dart';
import '../../../modules/inventory/repo/i_inventory_repo.dart';
import '../../../modules/inventory/repo/inventory_repo_http.dart';
import '../../../modules/inventory/service/i_inventory_service.dart';
import '../../../modules/inventory/service/inventory_service.dart';
import '../../../modules/overview/service/i_overview_service.dart';
import '../../icons/modules/inventory/inventory_icons.dart';

class InventoryBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<InventoryIcons>(() => InventoryIcons());
    Get.lazyPut<ICustomInventoryListview>(() => StaggeredSliverListview());

    Get.lazyPut<IInventoryRepo>(() => InventoryRepoHttp());
    Get.lazyPut<IInventoryService>(() => InventoryService(
          repo: Get.find<IInventoryRepo>(),
          overviewService: Get.find<IOverviewService>(),
        ));
    Get.lazyPut<InventoryController>(
        () => InventoryController(service: Get.find<IInventoryService>()));
  }
}