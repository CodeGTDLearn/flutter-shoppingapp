import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/cart/core/cart_bindings.dart';

import '../../../core/custom_widgets/custom_drawer.dart';
import '../../../core/properties/theme/app_theme_controller.dart';
import '../../cart/repo/cart_repo.dart';
import '../../cart/repo/i_cart_repo.dart';
import '../../inventory/core/inventory_bindings.dart';
import '../../orders/core/orders_bindings.dart';
import '../controller/overview_controller.dart';
import '../repo/i_overview_repo.dart';
import '../repo/overview_repo_firebase.dart';
import '../service/i_overview_service.dart';
import '../service/overview_service.dart';
import 'overview_appbar/filter_options.dart';
import 'overview_appbar/overview_appbar.dart';

class OverviewBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<AppThemeController>(() => AppThemeController());

    Get.lazyPut<CustomDrawer>(() => CustomDrawer());

    Get.lazyPut<OverviewAppBar>(() => OverviewAppBar(filter: FilterOptions.All));

    Get.lazyPut<IOverviewRepo>(() => OverviewRepoFirebase());

    Get.lazyPut<IOverviewService>(() => OverviewService(repo: Get.find<IOverviewRepo>()));

    Get.lazyPut<OverviewController>(
        () => OverviewController(service: Get.find<IOverviewService>()));

    // CUSTOM-DRAWER DEPENDENCIES
    Get.put<ICartRepo>(CartRepo(), permanent: true, tag: 'cartRepo');
    CartBindings().dependencies();
    OrdersBindings().dependencies();
    InventoryBindings().dependencies();
  }
}