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

import '../../app/modules/inventory/repo/inventory_mocked_repo.dart';
import '../../app/modules/overview/repo/overview_mocked_repo.dart';

class InventoryTestTitles {
  // @formatter:off
  //GROUP-TITLES ---------------------------------------------------------------
  static get INVENTORY_GROUP_TITLE => 'Inventory|Integration-Tests:';
  static get INVENTORY_EDIT_GROUP_TITLE => 'Inventory-Edit|Integration-Tests:';
  static get INVENTORY_VALIDATION_GROUP_TITLE => 'Inventory-Valid|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  String REPO_NAME = 'InventoryMockedRepo';
  get REPO_TEST_TITLE => '$REPO_NAME|Repo: Unit';
  get SERVICE_TEST_TITLE => '$REPO_NAME|Service: Unit';
  get CONTROLLER_TEST_TITLE => '$REPO_NAME|Controller: Integr';
  get VIEW_TEST_TITLE => '$REPO_NAME|View: Functional';
  get VIEW_TEST_VALID_TITLE => '$REPO_NAME|View-Edit|Validation: Functional';
  get VIEW_EDIT_TEST_TITLE => '$REPO_NAME|View-Edit: Functional';

  //TEST-TITLES ----------------------------------------------------------------
  get check_emptyView_noProductInDb => 'Checking products (empty DB)';
  get refresh_view => 'Refreshing View';
  get check_products => 'Checking Products';
  get delete_product => 'Deleting a product';
  get update_product => 'Updating a product';
  get tap_viewBackButton => 'Testing BackButton';

  //TEST-TITLES: TITLE CHECK VALIDATIONS + CHECK INJECTIONS --------------------
  get validation_title_size => 'Title|Validation|min 05 chars';
  get validation_title_inject => 'Title|Injection (OWASP)';
  get validation_title_empty => 'Title|Validation|empty not allowed';

  //TEST-TITLES: DESCRIPTION CHECK VALIDATIONS + CHECK INJECTIONS --------------
  get validation_descript_size => 'Description|Validation|min 10 chars';
  get validation_descript_inject => 'Description|Injection (OWASP)';
  get validation_descript_empty => 'Description|Validation|empty not allowed';

  //TEST-TITLES: PRICE CHECK VALIDATIONS + CHECK INJECTIONS --------------------
  get validation_price_size => 'Price|Validation|max 07 chars';
  get validation_price_inject => 'Price|Injection (OWASP)';
  get validation_price_empty => 'Price|Validation|empty not allowed';

  //TEST-TITLES: URL CHECK VALIDATIONS + CHECK INJECTIONS ----------------------
  get validation_url_size => 'Url Image|Validation|max 135 chars';
  get validation_url_inject => 'Url Image|Injection (OWASP)';
  get validation_url_empty => 'Url Image|Validation|empty not allowed';

  //TEST-TITLES: URL CHECK VALIDATIONS + CHECK INJECTIONS ----------------------
  get edit_back_button => 'Testing BackButton';
  get edit_add_product_in_form => 'Adding a product';
  get edit_preview_url_in_form => 'check previewImageUrl';
  get edit_fill_form_invalid => 'Filling fields testing INValidation';
  // @formatter:on
}
