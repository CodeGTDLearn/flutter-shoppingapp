import 'package:test/test.dart';

import 'managed_products_controller_test.dart';
import 'pages/managed_products_add_edit_page_test.dart';
import 'pages/managed_products_page_test.dart';
import 'repo/managed_products_repo_test.dart';
import 'service/managed_products_service_test.dart';

class ManagedProductsModuleTest {
  static void groups() {
    const MANAGED_PRODUCTS_MODULE_PAGE = 'Managed Products|';
    group(
      "$MANAGED_PRODUCTS_MODULE_PAGE\MockedRepo: Unit",
      ManagedProductsRepoTest.unit,
    );
    group(
      "$MANAGED_PRODUCTS_MODULE_PAGE\Service|MockedRepo: Unit",
      ManagedProductsServiceTest.unit,
    );
    group(
      "$MANAGED_PRODUCTS_MODULE_PAGE\Controller|Service|MockedRepo: Integr",
      ManagedProductsControllerTest.integration,
    );
    group(
      "$MANAGED_PRODUCTS_MODULE_PAGE\View|Managed Products Page: Functional",
      ManagedProductsPageTest.functional,
    );
    // group(
    //   "$MANAGED_PRODUCTS_MODULE_PAGE\View|Managed Products Add/Edit Page: Functional",
    //   ManagedProductsAddEditPageTest.functional,
    // );
  }
}
