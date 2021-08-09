import 'package:flutter_test/flutter_test.dart';

import '../app/modules/overview/overview_controller_test.dart';
import '../app/modules/overview/repo/overview_repo_test.dart';
import '../app/modules/overview/service/overview_service_test.dart';
import '../app/modules/overview/view/overview_details_functional_test.dart';
import '../app/modules/overview/view/overview_view_functional_test.dart';
import '../config/tests_config.dart';
import '../config/bindings/overview_test_bindings.dart';
import '../config/titles/overview_test_titles.dart';

class OverviewTestGroups {
  void groups(bool skipGroup) {
    group(
      OverviewTestTitles().REPO_TEST_TITLE,
      OverviewRepoTests.unit,
      skip: skipGroup, //'skip-group' overrides the internal 'skip-methods'
    );

    group(
      OverviewTestTitles().SERVICE_TEST_TITLE,
      OverviewServiceTests.unit,
      skip: skipGroup,
    );

    group(
      OverviewTestTitles().CONTROLLER_TEST_TITLE,
      OverviewControllerTests.integration,
      skip: skipGroup,
    );

    group(
      OverviewTestTitles().VIEW_TEST_TITLE,
      OverviewViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );

    group(
      OverviewTestTitles().DETAIL_VIEW_TEST_TITLE,
      OverviewDetailsTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
