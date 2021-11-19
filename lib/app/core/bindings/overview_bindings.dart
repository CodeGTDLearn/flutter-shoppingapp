import 'package:get/get.dart';

import '../../modules/overview/controller/overview_controller.dart';
import '../../modules/overview/repo/i_overview_repo.dart';
import '../../modules/overview/repo/overview_repo_firebase.dart';
import '../../modules/overview/service/i_overview_service.dart';
import '../../modules/overview/service/overview_service.dart';
import '../components/custom_drawer.dart';
import '../properties/theme/app_theme_controller.dart';
import 'cart_bindings.dart';
import 'inventory_bindings.dart';
import 'orders_bindings.dart';

class OverviewBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<AppThemeController>(() => AppThemeController());

    Get.lazyPut<CustomDrawer>(() => CustomDrawer());

    Get.lazyPut<IOverviewRepo>(() => OverviewRepoFirebase());

    Get.lazyPut<IOverviewService>(() => OverviewService(
          repo: Get.find<IOverviewRepo>(),
        ));

    Get.lazyPut<OverviewController>(() => OverviewController(
          service: Get.find<IOverviewService>(),
        ));

    OrdersBindings().dependencies();

    CartBindings().dependencies();

    InventoryBindings().dependencies();
  }
}