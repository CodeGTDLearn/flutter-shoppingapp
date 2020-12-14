import 'package:test/test.dart';

import 'orders_controller_test.dart';
import 'repo/orders_repo_test.dart';
import 'service/orders_service_test.dart';

class OrdersModuleTest {
  static void groups() {
    const MODULE = 'Orders|';

    group("$MODULE\MockedRepo: Unit", OrdersRepoTest.unit);

    group("$MODULE\Service|MockedRepo: Unit", OrdersServiceTest.unit);

    group("$MODULE\Controller|Service|MockedRepo: Integr",
        OrdersControllerTest.integration);
  }
}
