import 'package:test/test.dart';

import 'managed_products_controller_test.dart';
import 'repo/managed_products_repo_test.dart';
import 'service/managed_products_service_test.dart';

class ManagedProductsModuleTestGroups {
  static void groups() {
    const ORDERS_MODULE_PAGE = 'Managed Products|';
    group(
      "$ORDERS_MODULE_PAGE\MockedRepo: Unit",
      ManagedProductsRepoTest.unitTests,
    );
    group(
      "$ORDERS_MODULE_PAGE\Service|MockedRepo: Unit",
      ManagedProductsServiceTest.unitTests,
    );
    group(
      "$ORDERS_MODULE_PAGE\Controller|Service|MockedRepo: Integr",
      ManagedProductsControllerTest.integrationTests,
    );
  }
}
