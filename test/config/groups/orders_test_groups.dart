import 'package:flutter_test/flutter_test.dart';

import '../../app/modules/orders/orders_controller_test.dart';
import '../../app/modules/orders/repo/orders_repo_test.dart';
import '../../app/modules/orders/service/orders_service_test.dart';
import '../../app/modules/orders/view/orders_view_test.dart';
import '../app_tests_properties.dart';
import '../titles/orders_test_titles.dart';

class OrdersTestGroups {
  void groups({required bool skipGroup}) {
    group(
      OrdersTestTitles().REPO_TITLE,
      OrdersRepoTests().unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );
    group(
      OrdersTestTitles().SERVICE_TITLE,
      OrdersServiceTests().unit,
      skip: skipGroup,
    );
    group(
      OrdersTestTitles().CONTROLLER_TITLE,
      OrdersControllerTests().integration,
      skip: skipGroup,
    );
    group(
      OrdersTestTitles().VIEW_TITLE,
      OrdersViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}