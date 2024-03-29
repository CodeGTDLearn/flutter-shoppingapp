import 'package:flutter_test/flutter_test.dart';

import '../../../../config/app_tests_properties.dart';
import '../overview_controller_test.dart';
import '../repo/overview_repo_test.dart';
import '../service/overview_service_test.dart';
import '../view/overview_view_test.dart';
import 'overview_test_titles.dart';

class OverviewTestGroups {
  void groups({required bool skipGroup}) {
    group(
      OverviewTestTitles().REPO_TITLE,
      OverviewRepoTests().unit,
      skip: skipGroup, //'skip-group' overrides the internal 'skip-methods'
    );

    group(
      OverviewTestTitles().SERVICE_TITLE,
      OverviewServiceTests().unit,
      skip: skipGroup,
    );

    group(
      OverviewTestTitles().CONTROLLER_TITLE,
      OverviewControllerTests().integration,
      skip: skipGroup,
    );

    group(
      OverviewTestTitles().VIEW_TITLE,
      OverviewViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}