import 'dart:io';

import 'package:get/get_common/get_reset.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/bindings/modules/cart_bindings.dart';
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

    var binding = BindingsBuilder(() {
      // Get.lazyPut(() => GlobalThemeController());

      Get.lazyPut<IOverviewRepo>(() => repo);
      Get.lazyPut<IOverviewService>(
        () => OverviewService(repo: Get.find<IOverviewRepo>()),
      );
      Get.lazyPut(() => OverviewController(service: Get.find<IOverviewService>()));

      CartBindings().dependencies();
    });

    binding.builder();

    HttpOverrides.global = null;
  }

  void bindingsBuilder({required bool isWidgetTest, required bool isEmptyDb}) {
    if (isWidgetTest && !isEmptyDb) _bindingsBuilder(_mocked_repo);
    if (isWidgetTest && isEmptyDb) _bindingsBuilder(OverviewMockRepoEmptyDb());
  }
}