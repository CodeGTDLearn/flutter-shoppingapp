import 'package:test/test.dart';

import '../app/modules/overview/overview_controller_test.dart';
import '../app/modules/overview/repo/overview_repo_test.dart';
import '../app/modules/overview/service/overview_service_test.dart';
import '../app/modules/overview/view/overview_details_view_test.dart';
import '../app/modules/overview/view/overview_view_test.dart';
import '../config/app_tests_config.dart';
import '../config/overview_test_config.dart';

class OverviewTestGroups {
  void groups() {
    group("${OverviewTestConfig().REPO_TEST_TITLE}", OverviewRepoTests.unit);
    group("${OverviewTestConfig().SERVICE_TEST_TITLE}", OverviewServiceTests.unit);
    group("${OverviewTestConfig().CONTROLLER_TEST_TITLE}",
        OverviewControllerTests.integration);

    group(
      "${OverviewTestConfig().VIEW_TEST_TITLE}",
      OverviewViewTest(testType: WIDGET_TEST).functional,
    );

    group("${OverviewTestConfig().DETAIL_VIEW_TEST_TITLE}",
        OverviewDetailsViewTest(testType: WIDGET_TEST).functional);
  }
}
