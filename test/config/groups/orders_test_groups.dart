import 'package:flutter_test/flutter_test.dart';

import '../../app/modules/orders/orders_controller_test.dart';
import '../../app/modules/orders/repo/orders_repo_test.dart';
import '../../app/modules/orders/service/orders_service_test.dart';
import '../../app/modules/orders/view/orders_view_test.dart';
import '../tests_properties.dart';
import '../titles/orders_tests_titles.dart';

class OrdersTestGroups {
  void groups({required bool skipGroup}) {
    group(
      OrdersTestsTitles().REPO_TITLE,
      OrdersRepoTests.unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );
    group(
      OrdersTestsTitles().SERVICE_TITLE,
      OrdersServiceTests.unit,
      skip: skipGroup,
    );
    group(
      OrdersTestsTitles().CONTROLLER_TITLE,
      OrdersControllerTests.integration,
      skip: skipGroup,
    );
    group(
      OrdersTestsTitles().VIEW_TITLE,
      OrdersViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
