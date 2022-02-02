import 'package:flutter_test/flutter_test.dart';

import '../../../../config/app_tests_properties.dart';
import '../orders_controller_test.dart';
import '../orders_service_test.dart';
import '../repo/orders_repo_test.dart';
import '../view/orders_view_test.dart';
import 'orders_test_titles.dart';

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