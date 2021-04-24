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

import 'repo/overview_repo_mocks.dart';

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
class OverviewTestConfig {
  final IOverviewRepo _mocked_repo_used_in_this_module_tests = OverviewMockRepo();

  void bindingsBuilder() {
    Get.reset();

    expect(Get.isPrepared<DarkThemeController>(), isFalse);
    expect(Get.isPrepared<IOverviewRepo>(), isFalse);
    expect(Get.isPrepared<IOverviewService>(), isFalse);
    expect(Get.isPrepared<OverviewController>(), isFalse);
    expect(Get.isPrepared<CartController>(), isFalse);

    var binding = BindingsBuilder(() {
      Get.lazyPut<IOverviewRepo>(() => _mocked_repo_used_in_this_module_tests);

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

  String repoName() =>
      _mocked_repo_used_in_this_module_tests.runtimeType.toString();

  get REPO_TEST_TITLE => '${repoName()}|Repo: Unit';

  get SERVICE_TEST_TITLE => '${repoName()}|Service|Repo: Unit';

  get CONTROLLER_TEST_TITLE => '${repoName()}|Controller|Service|Repo: Integr';

  get VIEW_TEST_TITLE => '${repoName()}|View: Functional';

  get DETAIL_VIEW_TEST_TITLE => '${repoName()}|View|Details: Functional';
}
