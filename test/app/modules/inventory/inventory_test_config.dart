import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/modules/inventory/controller/inventory_controller.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';
import 'package:shopingapp/app/modules/inventory/service/inventory_service.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';

import '../overview/repo/overview_mocked_repo.dart';
import 'repo/inventory_mocked_repo.dart';

class InventoryTestConfig {
//REPO-USED-IN-THIS-TEST-MODULE:
  final IInventoryRepo _mocked_repo_used_in_this_module_tests =
      InventoryMockedRepo();

  void bindingsBuilder(IInventoryRepo mockRepo) {
    Get.reset();

    expect(Get.isPrepared<DarkThemeController>(), isFalse);

    expect(Get.isPrepared<IOverviewRepo>(), isFalse);
    expect(Get.isPrepared<IOverviewService>(), isFalse);
    expect(Get.isPrepared<OverviewController>(), isFalse);

    expect(Get.isPrepared<CartController>(), isFalse);

    expect(Get.isPrepared<IInventoryRepo>(), isFalse);
    expect(Get.isPrepared<IInventoryService>(), isFalse);
    expect(Get.isPrepared<InventoryController>(), isFalse);

    var binding = BindingsBuilder(() {
      Get.lazyPut<DarkThemeController>(() => DarkThemeController());

      Get.lazyPut<IInventoryRepo>(() => mockRepo);

      Get.lazyPut<IInventoryService>(() => InventoryService(
            repo: Get.find(),
            overviewService: Get.find(),
          ));

      Get.lazyPut<InventoryController>(
          () => InventoryController(service: Get.find()));

      Get.lazyPut<IOverviewRepo>(() => OverviewMockedRepo());

      Get.lazyPut<IOverviewService>(() => OverviewService(repo: Get.find()));

      Get.lazyPut<OverviewController>(
          () => OverviewController(service: Get.find()));

      CartBindings().dependencies();
    });

    binding.builder();

    expect(Get.isPrepared<DarkThemeController>(), isTrue);

    expect(Get.isPrepared<IOverviewRepo>(), isTrue);
    expect(Get.isPrepared<IOverviewService>(), isTrue);
    expect(Get.isPrepared<OverviewController>(), isTrue);

    expect(Get.isPrepared<CartController>(), isTrue);

    expect(Get.isPrepared<IInventoryRepo>(), isTrue);
    expect(Get.isPrepared<IInventoryService>(), isTrue);
    expect(Get.isPrepared<InventoryController>(), isTrue);

    HttpOverrides.global = null;
  }

  String repoName() =>
      _mocked_repo_used_in_this_module_tests.runtimeType.toString();

  get REPO_TEST_TITLE => '${repoName()}|Repo: Unit';

  get SERVICE_TEST_TITLE => '${repoName()}|Service|Repo: Unit';

  get CONTROLLER_TEST_TITLE => '${repoName()}|Controller|Service|Repo: Integr';

  get VIEW_TEST_TITLE => '${repoName()}|View: Functional';

  get VIEW_ADDEDIT_TEST_TITLE => '${repoName()}|View|Add/Edit: Functional';
}
