import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/properties/theme/app_theme_controller.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';

import '../../modules/overview/repo/overview_mocked_repo.dart';
import '../../modules/overview/repo/overview_mocked_repo_emptydb.dart';

class CustomWidgetsTestBindings {
  final IOverviewRepo _mocked_repo = OverviewMockedRepo();

  void _bindingsBuilder(IOverviewRepo repo) {
    Get.reset();

    expect(Get.isPrepared<AppThemeController>(), isFalse);
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

      Get.lazyPut<AppThemeController>(() => AppThemeController());

      CartBindings().dependencies();
    });

    binding.builder();

    expect(Get.isPrepared<AppThemeController>(), isTrue);
    expect(Get.isPrepared<IOverviewRepo>(), isTrue);
    expect(Get.isPrepared<IOverviewService>(), isTrue);
    expect(Get.isPrepared<OverviewController>(), isTrue);
    expect(Get.isPrepared<CartController>(), isTrue);

    HttpOverrides.global = null;
  }

  void bindingsBuilder({required bool isWidgetTest, required bool isEmptyDb}) {
    if (isWidgetTest && !isEmptyDb) _bindingsBuilder(_mocked_repo);
    if (isWidgetTest && isEmptyDb) _bindingsBuilder(OverviewMockRepoEmptyDb());
  }
}