import 'package:flutter_test/flutter_test.dart';

import '../app/modules/orders/orders_controller_test.dart';
import '../app/modules/orders/repo/orders_repo_test.dart';
import '../app/modules/orders/service/orders_service_test.dart';
import '../app/modules/orders/view/orders_view_functional_test.dart';
import '../config/app_tests_config.dart';
import '../config/orders_test_config.dart';

class OrdersTestGroups {
  void groups(bool skipGroup) {
    group(
      OrdersTestConfig().REPO_TEST_TITLE,
      OrdersRepoTests.unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );
    group(
      OrdersTestConfig().SERVICE_TEST_TITLE,
      OrdersServiceTests.unit,
      skip: skipGroup,
    );
    group(
      OrdersTestConfig().CONTROLLER_TEST_TITLE,
      OrdersControllerTests.integration,
      skip: skipGroup,
    );
    group(
      OrdersTestConfig().VIEW_TEST_TITLE,
      OrdersViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
