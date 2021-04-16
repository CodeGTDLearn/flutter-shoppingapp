import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/overview/repo/overview_repo_retrofit.dart';

import '../../../core/properties/theme/dark_theme_controller.dart';
import '../../cart/core/cart_bindings.dart';
import '../../components/drawwer.dart';
import '../../inventory/core/inventory_bindings.dart';
import '../../orders/core/orders_bindings.dart';
import '../controller/overview_controller.dart';
import '../repo/i_overview_repo.dart';
import '../repo/overview_repo_http.dart';
import '../service/i_overview_service.dart';
import '../service/overview_service.dart';

class OverviewBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<DarkThemeController>(() => DarkThemeController());

    Get.lazyPut<Drawwer>(() => Drawwer());

    // Get.lazyPut<Dio>(() => Dio());
    // Get.lazyPut<IOverviewRepo>(() => OverviewRepoRetrofit(Get.find<Dio>()));

    Get.lazyPut<IOverviewRepo>(() => OverviewRepoHttp());

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
