import 'package:test/test.dart';

import 'orders_controller_test.dart';
import 'repo/orders_repo_test.dart';
import 'service/orders_service_test.dart';

class OrdersModuleTestGroups {
  static void groups() {
    const ORDERS_MODULE_PAGE = 'Orders|';
    group("$ORDERS_MODULE_PAGE\MockedRepo: Unit", OrdersRepoTest.unitTests);
    group("$ORDERS_MODULE_PAGE\Service|MockedRepo: Unit", OrdersServiceTest.unitTests);
    group(
      "$ORDERS_MODULE_PAGE\Controller|Service|MockedRepo: Integr",
      OrdersControllerTest.integrationTests,
    );
  }
}