import 'dart:io';

import 'package:get/get_common/get_reset.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/bindings/modules/cart_bindings.dart';
import 'package:shopingapp/app/core/theme/global_theme_controller.dart';
import 'package:shopingapp/app/modules/inventory/controller/inventory_controller.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';
import 'package:shopingapp/app/modules/inventory/service/inventory_service.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';

import '../../modules/inventory/repo/inventory_mocked_repo.dart';
import '../../modules/inventory/repo/inventory_mocked_repo_emptydb.dart';
import '../../modules/overview/repo/overview_mocked_repo.dart';

class InventoryTestBindings {
  //REPO-USED-IN-THIS-TEST-MODULE:
  final IInventoryRepo _mocked_repo = InventoryMockedRepo();

  void _bindingsBuilder(IInventoryRepo mockRepo) {
    Get.reset();

    var binding = BindingsBuilder(() {
      Get.lazyPut<GlobalThemeController>(() => GlobalThemeController());

      Get.lazyPut<IOverviewRepo>(() => OverviewMockedRepo());
      Get.lazyPut<IOverviewService>(
          () => OverviewService(repo: Get.find<IOverviewRepo>()));
      Get.lazyPut<OverviewController>(
          () => OverviewController(service: Get.find<IOverviewService>()));

      Get.lazyPut<IInventoryRepo>(() => mockRepo);
      Get.lazyPut<IInventoryService>(() => InventoryService(
            repo: Get.find(),
            overviewService: Get.find(),
          ));
      Get.lazyPut<InventoryController>(() => InventoryController(service: Get.find()));

      CartBindings().dependencies();
    });

    binding.builder();

    HttpOverrides.global = null;
  }

  void bindingsBuilder({required bool isWidgetTest, required bool isEmptyDb}) {
    if (isWidgetTest && !isEmptyDb) _bindingsBuilder(_mocked_repo);
    if (isWidgetTest && isEmptyDb) _bindingsBuilder(InventoryMockedRepoEmptyDb());
  }
}