import 'package:flutter_test/flutter_test.dart';

import '../app/modules/orders/orders_controller_test.dart';
import '../app/modules/orders/repo/orders_repo_test.dart';
import '../app/modules/orders/service/orders_service_test.dart';
import '../app/modules/orders/view/orders_view_functional_test.dart';
import '../config/tests_config.dart';
import '../config/titles/orders_test_titles.dart';

class OrdersTestGroups {
  void groups(bool skipGroup) {
    group(
      OrdersTestTitles().REPO_TEST_TITLE,
      OrdersRepoTests.unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );
    group(
      OrdersTestTitles().SERVICE_TEST_TITLE,
      OrdersServiceTests.unit,
      skip: skipGroup,
    );
    group(
      OrdersTestTitles().CONTROLLER_TEST_TITLE,
      OrdersControllerTests.integration,
      skip: skipGroup,
    );
    group(
      OrdersTestTitles().VIEW_TEST_TITLE,
      OrdersViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
