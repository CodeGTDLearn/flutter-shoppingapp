import 'package:test/test.dart';

import 'orders_controller_test.dart';
import 'orders_test_config.dart';
import 'repo/orders_repo_test.dart';
import 'service/orders_service_test.dart';

class OrdersTestGroups {
  static void groups() {
    group("${OrdersTestConfig().ORDER_REPO}", OrdersRepoTest.unit);
    group("${OrdersTestConfig().ORDER_SERVICE}", OrdersServiceTest.unit);
    group("${OrdersTestConfig().ORDER_CONTROLLER}",OrdersControllerTest.integration);
    // group("${OrdersTestConfig().ORDER_VIEW}", OrdersPageTest.integration);
  }
}
