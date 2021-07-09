import 'package:test/test.dart';

import '../app/modules/overview/overview_controller_test.dart';
import '../app/modules/overview/repo/overview_repo_test.dart';
import '../app/modules/overview/service/overview_service_test.dart';
import '../app/modules/overview/view/overview_details_functional_test.dart';
import '../app/modules/overview/view/overview_view_functional_test.dart';
import '../config/app_tests_config.dart';
import '../config/overview_test_config.dart';

class OverviewTestGroups {
  void groups(bool skipGroup) {
    group(
      OverviewTestConfig().REPO_TEST_TITLE,
      OverviewRepoTests.unit,
      skip: skipGroup, //'skip-group' overrides the internal 'skip-methods'
    );

    group(
      OverviewTestConfig().SERVICE_TEST_TITLE,
      OverviewServiceTests.unit,
      skip: skipGroup,
    );

    group(
      OverviewTestConfig().CONTROLLER_TEST_TITLE,
      OverviewControllerTests.integration,
      skip: skipGroup,
    );

    group(
      OverviewTestConfig().VIEW_TEST_TITLE,
      OverviewViewFunctionalTest(testType: WIDGET_TEST).functional,
      skip: false,
    );

    group(
      OverviewTestConfig().DETAIL_VIEW_TEST_TITLE,
      OverviewDetailsFunctionalTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
