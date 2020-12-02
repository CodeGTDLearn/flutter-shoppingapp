import 'package:test/test.dart';

import '../app/pages_modules/managed_products/repo/managed_products_repo_test.dart';
import '../app/pages_modules/orders/orders_controller_test.dart';
import '../app/pages_modules/orders/repo/orders_repo_test.dart';
import '../app/pages_modules/orders/service/orders_service_test.dart';

class ManagedProductsModuleTestGroups {
  static void groups() {
    const ORDERS_MODULE_PAGE = 'Managed Products|';
    group("$ORDERS_MODULE_PAGE\MockedRepo: Unit", ManagedProductsRepoTest.unitTests);
    // group("$ORDERS_MODULE_PAGE\Service|MockedRepo: Unit", ManagedProductsServiceTest.unitTests);
    // group("$ORDERS_MODULE_PAGE\Controller|Service|MockedRepo: Integr",
    //   ManagedProductsControllerTest.integrationTests,
    // );
  }
}