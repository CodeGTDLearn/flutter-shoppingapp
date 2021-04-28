import 'package:test/test.dart';

import 'orders_controller_test.dart';
import 'orders_test_config.dart';
import 'orders_view_test.dart';
import 'repo/orders_repo_test.dart';
import 'service/orders_service_test.dart';

class OrdersTestGroups {
  static void groups() {
    // group("${OrdersTestConfig().REPO_TEST_TITLE}", OrdersRepoTest.unit);
    // group("${OrdersTestConfig().SERVICE_TEST_TITLE}", OrdersServiceTest.unit);
    // group("${OrdersTestConfig().CONTROLLER_TEST_TITLE}",OrdersControllerTest.integration);
    group("${OrdersTestConfig().VIEW_TEST_TITLE}", OrdersViewTest.functional);
  }
}
