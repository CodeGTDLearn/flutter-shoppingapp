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
  final IOverviewRepo _mocked_repo_used_in_this_module_tests = OverviewMockedRepo();

  void _bindingsBuilder(IOverviewRepo overviewRepo) {
    Get.reset();

    expect(Get.isPrepared<DarkThemeController>(), isFalse);
    expect(Get.isPrepared<IOverviewRepo>(), isFalse);
    expect(Get.isPrepared<IOverviewService>(), isFalse);
    expect(Get.isPrepared<OverviewController>(), isFalse);
    expect(Get.isPrepared<CartController>(), isFalse);

    var binding = BindingsBuilder(() {
      Get.lazyPut<IOverviewRepo>(() => overviewRepo);
      // Get.lazyPut<IOverviewRepo>(() => _mocked_repo_used_in_this_module_tests);

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

  void bindingsBuilderMockedRepo({bool isWidgetTest}) {
    if (isWidgetTest) _bindingsBuilder(_mocked_repo_used_in_this_module_tests);
  }

  void bindingsBuilderMockRepoEmptyDb({bool isWidgetTest}) {
    if (isWidgetTest) _bindingsBuilder(OverviewMockRepoEmptyDb());
  }

  String repoName() => _mocked_repo_used_in_this_module_tests.runtimeType.toString();

  // @formatter:off
  //GROUP-TITLES ---------------------------------------------------------------
  static get OVERVIEW_GROUP_TITLE => 'OverView|Integration-Tests:';
  static get OVERVIEW_DETAIL_GROUP_TITLE => 'OverView|Details|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  get REPO_TEST_TITLE => '${repoName()}|Repo: Unit';
  get SERVICE_TEST_TITLE => '${repoName()}|Service|Repo: Unit';
  get CONTROLLER_TEST_TITLE => '${repoName()}|Controller|Service|Repo: Integr';
  get VIEW_TEST_TITLE => '${repoName()}|View: Functional';
  get DETAIL_VIEW_TEST_TITLE => '${repoName()}|View|Details: Functional';

  //OVERVIEW-TEST-TITLES -------------------------------------------------------
  get check_products => 'Checking products';
  get toggle_favorite_status => 'Toggling FavoritesIconButton in a product';
  get add_prod_snackbar => 'Adding products + Checking Snackbar text';
  get add_prod_snackbar_undo => 'Adding products + Clicking Snackbar Undo';
  get add_prod1_3x_check_shopCartIcon => 'Adding a product 3x + Check ShopCartIcon';
  get add_prods1And2_check_shopCartIcon => 'Adding products 1/2 + Check ShopCartIcon';
  get add_prods3And4_check_shopCartIcon => 'Adding products 3/4 + Checking ShopCartIcon';
  get tap_fav_filter_no_favorites_found => 'Tap FavoriteFilter - favorites Not found';
  get tap_fav_filter => 'Tapping FavoriteFilter';
  get close_fav_filter => 'Closing Favorite_Filter (tap OUTSIDE)';

  //OVERVIEW-DETAILS-TEST-TITLES -----------------------------------------------
  get click_product_check_details_texts =>
      'Clicking Product 01 + Show Details Page: Checking texts';

  get click_product_check_details_image =>
      'Clicking Product 01 + Show Details Page: Checking image';
  // @formatter:on
}
