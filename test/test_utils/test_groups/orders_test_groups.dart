import 'package:test/test.dart';

import '../../app/modules/orders/orders_controller_test.dart';
import '../../app/modules/orders/repo/orders_repo_test.dart';
import '../../app/modules/orders/service/orders_service_test.dart';
import 'config.dart';

class OrdersTestGroups {
  static void groups() {
    group("$ORDER$ORDER_REPO", OrdersRepoTest.unit);

    group("$ORDER$ORDER_SERVICE", OrdersServiceTest.unit);

    group("$ORDER$ORDER_CONTROLLER", OrdersControllerTest.integration);

    // group("$ORDER$ORDER_VIEW",
    //     OrdersPageTest.integration);
  }
}
