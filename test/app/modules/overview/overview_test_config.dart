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

class OverviewTestConfig {
  /* INSTRUCTIONS ABOUT REPO-TESTS OR REPO-REAL-PRODUCTION
  https://timm.preetz.name/articles/http-request-flutter-test
  By default all HTTP request made in a test invoked with flutter test
  result in an empty response with status code 400.
  Generally that seems like a good default behavior to avoid external
  dependencies and hence reduce flakyness in tests.
  THEREFORE:
  - TESTS CAN NOT DO EXTERNAL-HTTP REQUESTS/CALLS;
  - HENCE, THE TESTS CAN NOT USE PRODUCTION-REAL-REPO
  - SO, THE TESTS ONLY WILL USE MockedRepoClass(no external calls)
   */
  final IOverviewRepo _ONLY_MOCKED_REPO = OverviewMockRepo();

  void bindingsBuilder() {
    Get.reset();

    expect(Get.isPrepared<DarkThemeController>(), isFalse);
    expect(Get.isPrepared<IOverviewRepo>(), isFalse);
    expect(Get.isPrepared<IOverviewService>(), isFalse);
    expect(Get.isPrepared<OverviewController>(), isFalse);
    expect(Get.isPrepared<CartController>(), isFalse);

    var binding = BindingsBuilder(() {
      Get.lazyPut<IOverviewRepo>(() => _ONLY_MOCKED_REPO);

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
  }

  String repoName() => _ONLY_MOCKED_REPO.runtimeType.toString();

  get REPO_TEST_TITLE => '${repoName()}|Repo: Unit';

  get SERVICE_TEST_TITLE => '${repoName()}|Service|Repo: Unit';

  get CONTROLLER_TEST_TITLE => '${repoName()}|Controller|Service|Repo: Integr';

  get VIEW_TEST_TITLE => '${repoName()}|View: Functional';

  get DETAIL_VIEW_TEST_TITLE => '${repoName()}|View|Details: Functional';
}
