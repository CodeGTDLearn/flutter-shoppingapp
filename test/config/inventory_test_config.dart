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

import '../app/modules/inventory/repo/inventory_mocked_repo.dart';
import '../app/modules/overview/repo/overview_mocked_repo.dart';

class InventoryTestConfig {
  //REPO-USED-IN-THIS-TEST-MODULE:
  final IInventoryRepo _mocked_repo_used_in_this_module_test = InventoryMockedRepo();

  void _bindingsBuilder(IInventoryRepo mockRepo) {
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

      Get.lazyPut<IOverviewRepo>(() => OverviewMockedRepo());
      Get.lazyPut<IOverviewService>(() => OverviewService(repo: Get.find()));
      Get.lazyPut<OverviewController>(() => OverviewController(service: Get.find()));

      Get.lazyPut<IInventoryRepo>(() => mockRepo);
      Get.lazyPut<IInventoryService>(() => InventoryService(
            repo: Get.find(),
            overviewService: Get.find(),
          ));
      Get.lazyPut<InventoryController>(() => InventoryController(service: Get.find()));

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

  void bindingsBuilderMockedRepo({bool isUnitTest}) {
    if (isUnitTest) _bindingsBuilder(_mocked_repo_used_in_this_module_test);
  }

  void bindingsBuilderMockedRepoEmptyDb({bool isWidgetTest}) {
    if (isWidgetTest) _bindingsBuilder(InventoryMockedRepoEmptyDb());
  }

  // @formatter:off
  //GROUP-TITLES ---------------------------------------------------------------
  static get INVENTORY_GROUP_TITLE => 'Inventory|Integration-Tests:';
  static get INVENTORY_EDIT_GROUP_TITLE => 'Inventory-Edit|Integration-Tests:';
  static get INVENTORY_VALIDATION_GROUP_TITLE => 'Inventory-Valid|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  String repoName() => _mocked_repo_used_in_this_module_test.runtimeType.toString();
  get REPO_TEST_TITLE => '${repoName()}|Repo: Unit';
  get SERVICE_TEST_TITLE => '${repoName()}|Service|Repo: Unit';
  get CONTROLLER_TEST_TITLE => '${repoName()}|Controller|Service|Repo: Integr';
  get VIEW_TEST_TITLE => '${repoName()}|View: Functional';
  get VIEW_TEST_VALID_TITLE => '${repoName()}|View|Edit|Validation: Functional';
  get VIEW_EDIT_TEST_TITLE => '${repoName()}|View|Edit: Functional';

  //TEST-TITLES ----------------------------------------------------------------
  get check_ProductsAbsence => 'Checking products (empty DB)';
  get refresh_View => 'Refreshing View';
  get check_Products => 'Checking Products';
  get delete_Product => 'Deleting a product';
  get update_Product => 'Updating a product';
  get view_BackButton => 'Testing BackButton';

  //TEST-TITLES: TITLE CHECK VALIDATIONS + CHECK INJECTIONS --------------------
  get validation_title_size => 'Title|Validation|min 05 chars';
  get validation_title_inject => 'Title|Check injection (OWASP)';
  get validation_title_empty => 'Title|Validation|empty not allowed';

  //TEST-TITLES: DESCRIPTION CHECK VALIDATIONS + CHECK INJECTIONS --------------
  get validation_descript_size => 'Description|Validation|min 10 chars';
  get validation_descript_inject => 'Description|Check injection (OWASP)';
  get validation_descript_empty => 'Description|Validation|empty not allowed';

  //TEST-TITLES: PRICE CHECK VALIDATIONS + CHECK INJECTIONS --------------------
  get validation_price_size => 'Price|Validation|max 07 chars';
  get validation_price_inject => 'Price|Check injection (OWASP)';
  get validation_price_empty => 'Price|Validation|empty not allowed';

  //TEST-TITLES: URL CHECK VALIDATIONS + CHECK INJECTIONS ----------------------
  get validation_url_size => 'Url Image|Validation|max 135 chars';
  get validation_url_inject => 'Url Image|Check injection (OWASP)';
  get validation_url_empty => 'Url Image|Validation|empty not allowed';

  //TEST-TITLES: URL CHECK VALIDATIONS + CHECK INJECTIONS ----------------------
  get edit_back_button => 'Testing Page BackButton';
  get edit_add_product_in_form => 'Adding a product';
  get edit_preview_url_in_form => 'check previewImageUrl';
  get edit_fill_form_invalid => 'Filling fields testing INValidation';
  // @formatter:on
}
