import 'package:get/instance_manager.dart';

import '../../../core/components/modal/core_modal_bindings.dart';
import '../../overview/service/i_overview_service.dart';
import '../controller/inventory_controller.dart';
import '../repo/i_inventory_repo.dart';
import '../repo/inventory_repo_http_firebase.dart';
import '../service/i_inventory_service.dart';
import '../service/inventory_service.dart';
import 'components/custom_listview/icustom_inventory_listview.dart';
import 'components/custom_listview/staggered_sliver_listview.dart';
import 'inventory_icons.dart';
import 'inventory_keys.dart';
import 'inventory_labels.dart';

class InventoryBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => InventoryKeys());
    Get.lazyPut(() => InventoryIcons());
    Get.lazyPut(() => InventoryLabels());

    CoreModalBindings().dependencies();

    Get.lazyPut<ICustomInventoryListview>(() => StaggeredSliverListview());
    Get.lazyPut<IInventoryRepo>(() => InventoryRepoHttpFirebase());
    Get.lazyPut<IInventoryService>(() => InventoryService(
          repo: Get.find<IInventoryRepo>(),
          overviewService: Get.find<IOverviewService>(),
        ));
    Get.lazyPut(() => InventoryController(service: Get.find<IInventoryService>()));
  }
}