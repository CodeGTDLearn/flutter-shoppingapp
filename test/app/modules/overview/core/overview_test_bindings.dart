import 'dart:io';

import 'package:get/get_common/get_reset.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';

import '../repo/overview_mocked_repo.dart';
import '../repo/overview_mocked_repo_emptydb.dart';

/* INSTRUCTIONS ABOUT 'REPO-REAL-DE-PRODUCAO' E 'REPO-REAL-DE-PRODUCAO'
  https://timm.preetz.name/articles/http-request-flutter-test
  By DEFAULT, HTTP request made in tests invoked BY flutter test
  result in an empty response (400).
  By DEFAULT, It is a good behavior to avoid external
  dependencies and hence reduce flakyness(FRAGILE) tests.
  THEREFORE:
  A) TESTS CAN NOT DO EXTERNAL-HTTP REQUESTS/CALLS;
  B) HENCE, THE TESTS CAN NOT USE 'REPO-REAL-DE-PRODUCAO'
  C) SO, THE TESTS ONLY WILL USE
     'REPO-REAL-DE-PRODUCAO'MockedRepoClass(no external calls)
   */
class OverviewTestBindings {
  final IOverviewRepo _mocked_repo = OverviewMockedRepo();

  void _bindingsBuilder(IOverviewRepo overviewRepo) {
    Get.reset();

    var binding = BindingsBuilder(() {
      // Get.lazyPut(() => GlobalThemeController());
      // Get.lazyPut(() => GlobalMessagesLabels());

      Get.lazyPut<IOverviewRepo>(() => overviewRepo);
      Get.lazyPut<IOverviewService>(
          () => OverviewService(repo: Get.find<IOverviewRepo>()));
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