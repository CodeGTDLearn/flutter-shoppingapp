import 'dart:io';

import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/modules/orders/controller/orders_controller.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';
import 'package:shopingapp/app/modules/orders/service/orders_service.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:test/test.dart';

import 'repo/orders_repo_mocks.dart';

class OrdersTestConfig {
  final IOrdersRepo _mocked_repo_used_in_this_module_tests = OrdersMockRepo();

  void bindingsBuilder() {
    Get.reset();

    expect(Get.isPrepared<DarkThemeController>(), isFalse);
    expect(Get.isPrepared<IOrdersRepo>(), isFalse);
    expect(Get.isPrepared<IOrdersService>(), isFalse);
    expect(Get.isPrepared<OrdersController>(), isFalse);

    var binding = BindingsBuilder(() {
      Get.lazyPut<IOrdersRepo>(() => _mocked_repo_used_in_this_module_tests);
      Get.lazyPut<IOrdersService>(
          () => OrdersService(repo: Get.find<IOrdersRepo>()));
      Get.lazyPut<OrdersController>(
          () => OrdersController(service: Get.find<IOrdersService>()));

      Get.lazyPut<DarkThemeController>(() => DarkThemeController());
    });

    binding.builder();

    expect(Get.isPrepared<DarkThemeController>(), isTrue);
    expect(Get.isPrepared<IOrdersRepo>(), isTrue);
    expect(Get.isPrepared<IOrdersService>(), isTrue);
    expect(Get.isPrepared<OrdersController>(), isTrue);

    HttpOverrides.global = null;
  }

  String repoName() =>
      _mocked_repo_used_in_this_module_tests.runtimeType.toString();

  get REPO_TEST_TITLE => '${repoName()}|Repo: Unit';

  get SERVICE_TEST_TITLE => '${repoName()}|Service|Repo: Unit';

  get CONTROLLER_TEST_TITLE => '${repoName()}|Controller|Service|Repo: Integr';

  get VIEW_TEST_TITLE => '${repoName()}|View: Functional';
}
