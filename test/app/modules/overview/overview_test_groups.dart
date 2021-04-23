import 'package:test/test.dart';

import 'overview_controller_test.dart';
import 'overview_test_config.dart';
import 'pages/overview_details_view_test.dart';
import 'pages/overview_view_test.dart';
import 'repo/overview_repo_test.dart';
import 'service/overview_service_test.dart';

class OverviewTestGroups {
  static void groups() {
    group("${OverviewTestConfig().REPO_TEST_TITLE}", OverviewRepoTest.unit);
    group("${OverviewTestConfig().SERVICE_TEST_TITLE}", OverviewServiceTest.unit);
    group("${OverviewTestConfig().CONTROLLER_TEST_TITLE}", OverviewControllerTest.integration);
    group("${OverviewTestConfig().VIEW_TEST_TITLE}", OverviewViewTest.functional);
    group("${OverviewTestConfig().DETAIL_VIEW_TEST_TITLE}", OverviewDetailsViewTest.functional);
  }
}
