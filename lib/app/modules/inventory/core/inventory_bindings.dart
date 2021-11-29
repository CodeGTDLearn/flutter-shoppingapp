import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/custom_widgets/custom_appbar.dart';

import '../../overview/controller/overview_controller.dart';
import '../../overview/repo/i_overview_repo.dart';
import '../../overview/repo/overview_repo_firebase.dart';
import '../../overview/service/i_overview_service.dart';
import '../../overview/service/overview_service.dart';
import '../controller/inventory_controller.dart';
import '../repo/i_inventory_repo.dart';
import '../repo/inventory_repo_firebase.dart';
import '../service/i_inventory_service.dart';
import '../service/inventory_service.dart';

class InventoryBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<CustomAppBar>(() => CustomAppBar());

    Get.lazyPut<IOverviewRepo>(() => OverviewRepoFirebase());

    Get.lazyPut<IOverviewService>(() => OverviewService(repo: Get.find<IOverviewRepo>()));

    Get.lazyPut<OverviewController>(
        () => OverviewController(service: Get.find<IOverviewService>()));

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