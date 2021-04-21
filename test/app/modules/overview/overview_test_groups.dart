import 'package:test/test.dart';

import 'overview_controller_test.dart';
import 'overview_test_config.dart';
import 'pages/overview_details_view_test.dart';
import 'pages/overview_view_test.dart';
import 'repo/overview_repo_test.dart';
import 'service/overview_service_test.dart';

class OverviewTestGroups {
  static void groups() {
    group("${OverviewTestConfig().OVERVIEW_REPO}", OverviewRepoTest.unit);
    group("${OverviewTestConfig().OVERVIEW_SERVICE}", OverviewServiceTest.unit);
    group("${OverviewTestConfig().OVERVIEW_CONTROLLER}", OverviewControllerTest.integration);
    // group("${OverviewTestConfig().OVERVIEW_VIEW}", OverviewViewTest.functional);
    // group("${OverviewTestConfig().OVERVIEW_DETAIL_VIEW}", OverviewDetailsViewTest.functional);
  }
}
