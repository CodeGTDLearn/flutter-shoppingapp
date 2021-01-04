import 'package:test/test.dart';

import 'managed_products_controller_test.dart';
import 'pages/managed_product_add_edit_page_test.dart';
import 'pages/managed_products_page_test.dart';

class ManagedProductsModuleTest {
  static void groups() {
    const MODULE = 'Managed Products|';
    //
    // group("$MODULE\MockedRepo: Unit", ManagedProductsRepoTest.unit);
    //
    // group("$MODULE\Service|MockedRepo: Unit", ManagedProductsServiceTest.unit);

    group("$MODULE\Controller|Service|MockedRepo: Integr",
        ManagedProductsControllerTest.integration);

    group("$MODULE\View|Managed Products Page: Functional",
        ManagedProductsPageTest.functional);

    group("$MODULE\View| Add/Edit Page: Functional",
        ManagedProductsAddEditPageTest.functional);
  }
}
