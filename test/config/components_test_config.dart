import 'dart:io';

import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../app/modules/overview/repo/overview_mocked_repo.dart';

class ComponentsTestConfig {
  final IOverviewRepo _mocked_repo_used_in_this_module_tests = OverviewMockedRepo();

  void _bindingsBuilder(IOverviewRepo repo) {
    Get.reset();

    expect(Get.isPrepared<DarkThemeController>(), isFalse);
    expect(Get.isPrepared<IOverviewRepo>(), isFalse);
    expect(Get.isPrepared<IOverviewService>(), isFalse);
    expect(Get.isPrepared<OverviewController>(), isFalse);
    expect(Get.isPrepared<CartController>(), isFalse);

    var binding = BindingsBuilder(() {
      Get.lazyPut<IOverviewRepo>(() => repo);

      Get.lazyPut<IOverviewService>(
          () => OverviewService(repo: Get.find<IOverviewRepo>()));
      Get.lazyPut<OverviewController>(
          () => OverviewController(service: Get.find<IOverviewService>()));

      Get.lazyPut<DarkThemeController>(() => DarkThemeController());

      CartBindings().dependencies();
    });

    binding.builder();

    expect(Get.isPrepared<DarkThemeController>(), isTrue);
    expect(Get.isPrepared<IOverviewRepo>(), isTrue);
    expect(Get.isPrepared<IOverviewService>(), isTrue);
    expect(Get.isPrepared<OverviewController>(), isTrue);
    expect(Get.isPrepared<CartController>(), isTrue);

    HttpOverrides.global = null;
  }

  void bindingsBuilderMockedRepo() {
    _bindingsBuilder(_mocked_repo_used_in_this_module_tests);
  }

  void bindingsBuilderMockRepoEmptyDb() {
    _bindingsBuilder(OverviewMockRepoEmptyDb());
  }

  // String repoName() => _mocked_repo_used_in_this_module_tests.runtimeType.toString();

  get DRAWWER_TEST_TITLE => 'Components|Drawer: Functional';

  get PROGR_IND_TEST_TITLE => 'Components|ProgresIndic: Functional';
}